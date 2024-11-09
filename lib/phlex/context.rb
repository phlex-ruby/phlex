# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize(user_context: {}, view_context: nil)
		@buffer = +""
		@capturing = false
		@user_context = user_context
		@fragments = nil
		@in_target_fragment = false
		@halt_signal = nil
		@view_context = view_context
	end

	attr_accessor :buffer, :capturing, :user_context, :in_target_fragment

	attr_reader :fragments, :view_context

	def target_fragments(fragments)
		@fragments = fragments.to_h { |it| [it, true] }
	end

	def around_render
		return yield if !@fragments || @halt_signal

		catch do |signal|
			@halt_signal = signal
			yield
		end
	end

	def begin_target(id)
		@in_target_fragment = id
	end

	def end_target
		@fragments.delete(@in_target_fragment)
		@in_target_fragment = false
		throw @halt_signal if @fragments.length == 0
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
