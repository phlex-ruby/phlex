# frozen_string_literal: true

# @api private
class Phlex::SGML::Renderer
	def initialize(user_context: {}, view_context: nil)
		@buffer = +""
		@capturing = false
		@user_context = user_context
		@fragments = nil
		@fragment_depth = 0
		@cache_stack = []
		@halt_signal = nil
		@view_context = view_context
	end

	attr_accessor :buffer, :capturing, :user_context

	attr_reader :fragments, :fragment_depth, :view_context

	def target_fragments(fragments)
		@fragments = fragments.to_set
	end

	def around_render
		return yield if !@fragments || @halt_signal

		catch do |signal|
			@halt_signal = signal
			yield
		end
	end

	def should_render?
		!@fragments || @fragment_depth > 0
	end

	def begin_fragment(id)
		@fragment_depth += 1 if @fragments&.include?(id)

		if caching?
			current_byte_offset = 0                                 		# Start tracking the byte offset of this fragment from the start of the cache buffer
			@cache_stack.reverse_each do |(cache_buffer, fragment_map)| # We'll iterate deepest to shallowest
				current_byte_offset += cache_buffer.bytesize		      		# Add the length of the cache buffer to the current byte offset
				fragment_map[id] = [current_byte_offset, nil, []]     		# Record the byte offset, length, and store a list of the nested fragments

				fragment_map.each do |name, (_offset, length, nested_fragments)| # Iterate over the other fragments
					next if name == id || length                       						 # Skip if it's the current fragment, or if the fragment has already ended
					nested_fragments << id                                       	 # Add the current fragment to the list of nested fragments
				end
			end
		end
	end

	def end_fragment(id)
		if caching?
			byte_length = nil
			@cache_stack.reverse_each do |(cache_buffer, fragment_map)|   # We'll iterate deepest to shallowest
				byte_length ||= cache_buffer.bytesize - fragment_map[id][0] # The byte length is the difference between the current byte offset and the byte offset of the fragment
				fragment_map[id][1] = byte_length                           # All cache contexts will use the same by
			end
		end

		return unless @fragments&.include?(id)

		@fragments.delete(id)
		@fragment_depth -= 1
		throw @halt_signal if @fragments.length == 0
	end

	def record_fragment(id, offset, length, nested_fragments)
		return unless caching?

		@cache_stack.reverse_each do |(cache_buffer, fragment_map)|
			offset += cache_buffer.bytesize
			fragment_map[id] = [offset, length, nested_fragments]
		end
	end

	def caching(&)
		buffer = +""
		@cache_stack.push([buffer, {}].freeze)
		capturing_into(buffer, &)
		@cache_stack.pop
	end

	def caching?
		@cache_stack.length > 0
	end

	def capturing_into(new_buffer)
		original_buffer = @buffer
		original_capturing = @capturing
		original_fragments = @fragments

		begin
			@buffer = new_buffer
			@capturing = true
			@fragments = nil
			yield
		ensure
			@buffer = original_buffer
			@capturing = original_capturing
			@fragments = original_fragments
		end

		new_buffer
	end
end
