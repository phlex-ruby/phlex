module Phlex
	# **Standard Generalized Markup Language** for behaviour common to {HTML} and {SVG}.
	module Renderable
		def self.included(including_class)
			including_class.extend(ClassMethods)
		end

		module ClassMethods
			# Render the view to a String. Arguments are delegated to {.new}.
			def call(...)
				new(...).call
			end

			# Create a new instance of the component.
			# @note The block will not be delegated {#initialize}. Instead, it will be sent to {#template} when rendering.
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

		# @!method initialize
		# @abstract Override to define an initializer for your component.
		# @note Your initializer will not receive a block passed to {.new}. Instead, this block will be sent to {#template} when rendering.
		# @example
		# 	def initialize(articles:)
		# 		@articles = articles
		# 	end

		# @abstract Override to define a template for your component.
		# @example
		# 	def template
		# 		h1 { "👋 Hello World!" }
		# 	end
		# @example Your template may yield a content block.
		# 	def template
		# 		main {
		# 			h1 { "Hello World" }
		# 			yield
		# 		}
		# 	end
		# @example Alternatively, you can delegate the content block to an element.
		# 	def template(&block)
		# 		article(class: "card", &block)
		# 	end
		def template
			yield
		end

		# @api private
		def await(task)
			if task.is_a?(Concurrent::IVar)
				flush if task.pending?

				task.wait.value
			elsif defined?(Async::Task) && task.is_a?(Async::Task)
				flush if task.running?

				task.wait
			else
				raise ArgumentError, "Expected an asynchronous task / promise."
			end
		end

		# Renders the view and returns the buffer. The default buffer is a mutable String.
		def call(buffer = +"", context: Phlex::Context.new, view_context: nil, parent: nil, &block)
			__final_call__(buffer, context: context, view_context: view_context, parent: parent, &block).tap do
				self.class.rendered_at_least_once!
			end
		end

		# @api private
		def __final_call__(buffer = +"", context: Phlex::Context.new, view_context: nil, parent: nil, &block)
			@_buffer = buffer
			@_context = context
			@_view_context = view_context
			@_parent = parent

			block ||= @_content_block

			return "" unless render?

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

			buffer << context.target unless parent
		end

		# Output text content. The text will be HTML-escaped.
		# @param content [String, Symbol, Integer, void] the content to be output on the buffer. Strings, Symbols, and Integers are handled by `plain` directly, but any object can be handled by overriding `format_object`
		# @return [nil]
		# @see #format_object
		def plain(content)
			unless __text__(content)
				raise ArgumentError, "You've passed an object to plain that is not handled by format_object. See https://rubydoc.info/gems/phlex/Phlex/SGML#format_object-instance_method for more information"
			end

			nil
		end

		# Output a whitespace character. This is useful for getting inline elements to wrap. If you pass a block, a whitespace will be output before and after yielding the block.
		# @return [nil]
		# @yield If a block is given, it yields the block with no arguments.
		def whitespace(&block)
			target = @_context.target

			target << " "

			if block_given?
				yield_content(&block)
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

			@_context.capturing_into(+"") { yield_content(&block) }
		end

		private

		# @api private
		def flush
			return if @_context.capturing

			target = @_context.target
			@_buffer << target.dup
			target.clear
		end

		# Render another component, block or enumerable
		# @return [nil]
		# @overload render(component, &block)
		# 	Renders the component.
		# 	@param component [Phlex::SGML]
		# @overload render(component_class, &block)
		# 	Renders a new instance of the component class. This is useful for component classes that take no arguments.
		# 	@param component_class [Class<Phlex::SGML>]
		# @overload render(proc)
		# 	Renders the proc with {#yield_content}.
		# 	@param proc [Proc]
		# @overload render(enumerable)
		# 	Renders each item of the enumerable.
		# 	@param enumerable [Enumerable]
		# 	@example
		# 		render @items
		def render(renderable, &block)
			case renderable
													when Phlex::SGML
														renderable.call(@_buffer, context: @_context, view_context: @_view_context, parent: self, &block)
													when Class
														if renderable < Phlex::SGML
															renderable.new.call(@_buffer, context: @_context, view_context: @_view_context, parent: self, &block)
														end
													when Enumerable
														renderable.each { |r| render(r, &block) }
													when Proc, Method
														if renderable.arity == 0
															yield_content_with_no_args(&renderable)
														else
															yield_content(&renderable)
														end
													when String
														plain(renderable)
													else
														raise ArgumentError, "You can't render a #{renderable.inspect}."
			end

			nil
		end

		# Like {#capture} but the output is vanished into a BlackHole buffer.
		# Because the BlackHole does nothing with the output, this should be faster.
		# @return [nil]
		# @api private
		def __vanish__(*args)
			return unless block_given?

			@_context.capturing_into(BlackHole) { yield(*args) }

			nil
		end

		# Determines if the component should render. By default, it returns `true`.
		# @abstract Override to define your own predicate to prevent rendering.
		# @return [Boolean]
		def render?
			true
		end

		# Format the object for output
		# @abstract Override to define your own format handling for different object types. Please remember to call `super` in the case that the passed object doesn't match, so that object formatting can be added at different layers of the inheritance tree.
		# @return [String]
		def format_object(object)
			case object
													when Float, Integer
														object.to_s
			end
		end

		# @abstract Override this method to hook in around a template render. You can do things before and after calling `super` to render the template. You should always call `super` so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		def around_template
			before_template
			yield
			after_template

			nil
		end

		# @abstract Override this method to hook in right before a template is rendered. Please remember to call `super` so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		def before_template
			nil
		end

		# @abstract Override this method to hook in right after a template is rendered. Please remember to call `super` so that callbacks can be added at different layers of the inheritance tree.
		# @return [nil]
		def after_template
			nil
		end

		# Yields the block and checks if it buffered anything. If nothing was buffered, the return value is treated as text. The text is always HTML-escaped.
		# @yieldparam component [self]
		# @return [nil]
		def yield_content
			return unless block_given?

			target = @_context.target

			original_length = target.length
			content = yield(self)
			__text__(content) if original_length == target.length

			nil
		end

		# Same as {#yield_content} but yields no arguments.
		# @yield Yields the block with no arguments.
		def yield_content_with_no_args
			return unless block_given?

			target = @_context.target

			original_length = target.length
			content = yield
			__text__(content) if original_length == target.length

			nil
		end

		# Same as {#yield_content} but accepts a splat of arguments to yield. This is slightly slower than {#yield_content}.
		# @yield [*args] Yields the given arguments.
		# @return [nil]
		def yield_content_with_args(*args)
			return unless block_given?

			target = @_context.target

			original_length = target.length
			content = yield(*args)
			__text__(content) if original_length == target.length

			nil
		end

		# Performs the same task as the public method #plain, but does not raise an error if an unformattable object is passed
		# @api private
		def __text__(content)
			case content
													when String
														@_context.target << ERB::Escape.html_escape(content)
													when Symbol
														@_context.target << ERB::Escape.html_escape(content.name)
													when nil
														nil
													else
														if (formatted_object = format_object(content))
															@_context.target << ERB::Escape.html_escape(formatted_object)
														else
															return false
														end
			end

			true
		end

		# @api private
		def __attributes__(**attributes)
			__final_attributes__(**attributes).tap do |buffer|
				Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] = buffer.freeze
			end
		end

		# @api private
		def __final_attributes__(**attributes)
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
		def __build_attributes__(attributes, buffer:)
			attributes.each do |k, v|
				next unless v

				name = case k
															when String then k
															when Symbol then k.name.tr("_", "-")
															else raise ArgumentError, "Attribute keys should be Strings or Symbols."
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
														when Integer, Float
															buffer << " " << name << '="' << v.to_s << '"'
														when Hash
															__build_attributes__(
																v.transform_keys { |subkey|
																	case subkey
																		when Symbol then"#{name}-#{subkey.name.tr('_', '-')}"
																		else "#{name}-#{subkey}"
																	end
																}, buffer: buffer
															)
														when Array
															buffer << " " << name << '="' << ERB::Escape.html_escape(v.compact.join(" ")) << '"'
														when Set
															buffer << " " << name << '="' << ERB::Escape.html_escape(v.to_a.compact.join(" ")) << '"'
														else
															buffer << " " << name << '="' << ERB::Escape.html_escape(v.to_str) << '"'
				end
			end

			buffer
		end
	end
end
