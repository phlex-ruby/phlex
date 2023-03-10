# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Phlex::Overrides::Symbol::Name
end

module Phlex
	class SGML
		class << self
			# Render the view to a String. Arguments are delegated to <code>new</code>.
			def call(...)
				new(...).call
			end

			# Create a new instance of the component.
			# @note The block will not be delegated to the initializer. Instead, it will be provided to `template` when rendering.
			def new(*args, **kwargs, &block)
				if block
					object = super(*args, **kwargs, &nil)
					object.instance_variable_set(:@_content_block, block)
					object
				else
					super
				end
			end

			# @api private
			def rendered_at_least_once!
				alias_method :__attributes__, :__final_attributes__
				alias_method :call, :__final_call__
			end

			# @api private
			def element_method?(method_name)
				return false unless instance_methods.include?(method_name)

				owner = instance_method(method_name).owner

				return true if owner.is_a?(Phlex::Elements) && owner.registered_elements[method_name]

				false
			end
		end

		# Renders the view and returns the buffer. The default buffer is a mutable String.
		def call(buffer = nil, context: Phlex::Context.new, view_context: nil, parent: nil, &block)
			__final_call__(buffer, context: context, view_context: view_context, parent: parent, &block).tap do
				self.class.rendered_at_least_once!
			end
		end

		# @api private
		def __final_call__(buffer = nil, context: Phlex::Context.new, view_context: nil, parent: nil, &block)
			@_context = context
			@_view_context = view_context
			@_parent = parent

			block ||= @_content_block

			return buffer || context.target unless render?

			around_template do
				if block
					if is_a?(DeferredRender)
						__vanish__(self, &block)
						template
					else
						template do |*args|
							if args.length > 0
								yield_content_with_args(*args, &block)
							else
								yield_content(&block)
							end
						end
					end
				else
					template
				end
			end

			buffer ? (buffer << context.target) : context.target
		end

		# Render another view
		# @param renderable [Phlex::SGML]
		# @return [nil]
		def render(renderable, &block)
			case renderable
			when Phlex::SGML
				renderable.call(context: @_context, view_context: @_view_context, parent: self, &block)
			when Class
				if renderable < Phlex::SGML
					renderable.new.call(context: @_context, view_context: @_view_context, parent: self, &block)
				end
			when Enumerable
				renderable.each { |r| render(r, &block) }
			when Proc
				yield_content(&renderable)
			else
				raise ArgumentError, "You can't render a #{renderable}."
			end

			nil
		end

		# Output text content. The text will be HTML-escaped.
		# @return [nil]
		def plain(content)
			case content
			when String
				@_context.target << ERB::Escape.html_escape(content)
			when Symbol
				@_context.target << ERB::Escape.html_escape(content.name)
			when Integer
				@_context.target << ERB::Escape.html_escape(content.to_s)
			when nil
				nil
			else
				if (formatted_object = format_object(content))
					@_context.target << ERB::Escape.html_escape(formatted_object)
				end
			end

			nil
		end

		# Output a whitespace character. This is useful for getting inline elements to wrap. If you pass a block, a whitespace will be output before and after yielding the block.
		# @return [nil]
		def whitespace
			target = @_context.target

			target << " "

			if block_given?
				yield
				target << " "
			end

			nil
		end

		# Output an HTML comment.
		# @return [nil]
		def comment(&block)
			target = @_context.target

			target << "<!-- "
			yield_content(&block)
			target << " -->"

			nil
		end

		# This method is very dangerous and should usually be avoided. It will output the given String without any HTML safety. You should never use this method to output unsafe user input.
		# @param content [String|nil]
		# @return [nil]
		def unsafe_raw(content = nil)
			return nil unless content

			@_context.target << content
			nil
		end

		# Capture a block of output as a String.
		# @note This only works if the block's receiver is the current component or the block returns a String.
		# @return [String]
		def capture(&block)
			return "" unless block

			@_context.with_target(+"") { yield_content(&block) }
		end

		# Like `capture` but the output is vanished into a BlackHole buffer.
		# Because the BlackHole does nothing with the output, this should be faster.
		# @return [nil]
		private def __vanish__(*args)
			return unless block_given?

			@_context.with_target(BlackHole) { yield(*args) }

			nil
		end

		# Default render predicate can be overridden to prevent rendering
		# @return [bool]
		private def render?
			true
		end

		# Format the object for output
		# @return [String]
		private def format_object(object)
			case object
			when Float
				object.to_s
			end
		end

		# Override this method to hook in around a template render. You can do things before and after calling <code>super</code> to render the template. You should always call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		private def around_template
			before_template
			yield
			after_template

			nil
		end

		# Override this method to hook in right before a template is rendered. Please remember to call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		private def before_template
			nil
		end

		# Override this method to hook in right after a template is rendered. Please remember to call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		private def after_template
			nil
		end

		# Yields the block and checks if it buffered anything. If nothing was buffered, the return value is treated as text.
		# @return [nil]
		private def yield_content
			return unless block_given?

			target = @_context.target

			original_length = target.length
			content = yield(self)
			plain(content) if original_length == target.length

			nil
		end

		# Same as <code>yield_content</code> but accepts a splat of arguments to yield. This is slightly slower than <code>yield_content</code>, which is why it's defined as a different method because we don't always need arguments so we can usually use <code>yield_content</code> instead.
		# @return [nil]
		private def yield_content_with_args(*args)
			return unless block_given?

			target = @_context.target

			original_length = target.length
			content = yield(*args)
			plain(content) if original_length == target.length

			nil
		end

		# @api private
		private def __attributes__(**attributes)
			__final_attributes__(**attributes).tap do |buffer|
				Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] = buffer.freeze
			end
		end

		# @api private
		private def __final_attributes__(**attributes)
			if respond_to?(:process_attributes)
				attributes = process_attributes(**attributes)
			end

			if attributes[:href]&.start_with?(/\s*javascript:/)
				attributes.delete(:href)
			end

			if attributes["href"]&.start_with?(/\s*javascript:/)
				attributes.delete("href")
			end

			buffer = +""
			__build_attributes__(attributes, buffer: buffer)

			buffer
		end

		# @api private
		private def __build_attributes__(attributes, buffer:)
			attributes.each do |k, v|
				next unless v

				name = case k
					when String then k
					when Symbol then k.name.tr("_", "-")
					else k.to_s
				end

				# Detect unsafe attribute names. Attribute names are considered unsafe if they match an event attribute or include unsafe characters.
				if HTML::EVENT_ATTRIBUTES[name] || name.match?(/[<>&"']/)
					raise ArgumentError, "Unsafe attribute name detected: #{k}."
				end

				case v
				when true
					buffer << " " << name
				when String
					buffer << " " << name << '="' << ERB::Escape.html_escape(v) << '"'
				when Symbol
					buffer << " " << name << '="' << ERB::Escape.html_escape(v.name) << '"'
				when Hash
					__build_attributes__(
						v.transform_keys { |subkey|
							case subkey
								when Symbol then"#{k}-#{subkey.name.tr('_', '-')}"
								else "#{k}-#{subkey}"
							end
						}, buffer: buffer
					)
				else
					buffer << " " << name << '="' << ERB::Escape.html_escape(v.to_s) << '"'
				end
			end

			buffer
		end
	end
end
