# frozen_string_literal: true

module Phlex
	# **Standard Generalized Markup Language** for behaviour common to {HTML} and {SVG}.
	class SGML
		include Helpers

		class << self
			# Render the view to a String. Arguments are delegated to {.new}.
			def call(...)
				new(...).call
			end

			# Create a new instance of the component.
			# @note The block will not be delegated {#initialize}. Instead, it will be sent to {#template} when rendering.
			def new(*, **, &block)
				if block
					object = super(*, **, &nil)
					object.instance_exec { @_content_block = block }
					object
				else
					super
				end
			end

			# @api private
			def __element_method__?(method_name)
				if instance_methods.include?(method_name)
					owner = instance_method(method_name).owner

					if Phlex::Elements === owner && owner.registered_elements[method_name]
						true
					else
						false
					end
				else
					false
				end
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
		# 	def view_template
		# 		h1 { "👋 Hello World!" }
		# 	end
		# @example Your template may yield a content block.
		# 	def view_template
		# 		main {
		# 			h1 { "Hello World" }
		# 			yield
		# 		}
		# 	end
		# @example Alternatively, you can delegate the content block to an element.
		# 	def view_template(&block)
		# 		article(class: "card", &block)
		# 	end
		def view_template
			if block_given?
				yield
			end
		end

		def await(task)
			case task
			when defined?(Concurrent::IVar) && Concurrent::IVar
				flush if task.pending?
				task.wait.value
			when defined?(Async::Task) && Async::Task
				flush if task.running?
				task.wait
			else
				raise ArgumentError.new("Expected an asynchronous task / promise.")
			end
		end

		# Renders the view and returns the buffer. The default buffer is a mutable String.
		def call(buffer = +"", context: Phlex::Context.new, view_context: nil, parent: nil, fragments: nil, &block)
			@_buffer = buffer
			@_context = context
			@_view_context = view_context
			@_parent = parent

			raise Phlex::DoubleRenderError.new("You can't render a #{self.class.name} more than once.") if @_rendered
			@_rendered = true

			if fragments
				@_context.target_fragments(fragments)
			end

			block ||= @_content_block

			return "" unless render?

			if !parent && Phlex::SUPPORTS_FIBER_STORAGE
				original_fiber_storage = Fiber[:__phlex_component__]
				Fiber[:__phlex_component__] = self
			end

			@_context.around_render do
				around_template do
					if block
						if DeferredRender === self
							__vanish__(self, &block)
							view_template
						else
							view_template do |*args|
								if args.length > 0
									yield_content_with_args(*args, &block)
								else
									yield_content(&block)
								end
							end
						end
					else
						view_template
					end
				end
			end

			unless parent
				if Phlex::SUPPORTS_FIBER_STORAGE
					Fiber[:__phlex_component__] = original_fiber_storage
				end
				buffer << context.buffer
			end
		end

		# Access the current render context data
		# @return the supplied context object, by default a Hash
		def context
			@_context.user_context
		end

		# Output text content. The text will be HTML-escaped.
		# @param content [String, Symbol, Integer, void] the content to be output on the buffer. Strings, Symbols, and Integers are handled by `plain` directly, but any object can be handled by overriding `format_object`
		# @return [nil]
		# @see #format_object
		def plain(content)
			unless __text__(content)
				raise ArgumentError.new("You've passed an object to plain that is not handled by format_object. See https://rubydoc.info/gems/phlex/Phlex/SGML#format_object-instance_method for more information")
			end

			nil
		end

		# Output a whitespace character. This is useful for getting inline elements to wrap. If you pass a block, a whitespace will be output before and after yielding the block.
		# @return [nil]
		# @yield If a block is given, it yields the block with no arguments.
		def whitespace(&)
			context = @_context
			return if context.fragments && !context.in_target_fragment

			buffer = context.buffer

			buffer << " "

			if block_given?
				yield_content(&)
				buffer << " "
			end

			nil
		end

		# Output an HTML comment.
		# @return [nil]
		def comment(&)
			context = @_context
			return if context.fragments && !context.in_target_fragment

			buffer = context.buffer

			buffer << "<!-- "
			yield_content(&)
			buffer << " -->"

			nil
		end

		# This method is very dangerous and should usually be avoided. It will output the given String without any HTML safety. You should never use this method to output unsafe user input.
		# @param content [String|nil]
		# @return [nil]
		def unsafe_raw(content = nil)
			return nil unless content

			context = @_context
			return if context.fragments && !context.in_target_fragment

			context.buffer << content
			nil
		end

		# Capture a block of output as a String.
		# @note This only works if the block's receiver is the current component or the block returns a String.
		# @return [String]
		def capture(*args, &block)
			return "" unless block

			if args.length > 0
				@_context.capturing_into(+"") { yield_content_with_args(*args, &block) }
			else
				@_context.capturing_into(+"") { yield_content(&block) }
			end
		end

		def tag(name, ...)
			normalized_name = case name
				when Symbol then name.name.downcase
				when String then name.downcase
				else raise ArgumentError.new("Expected the tag name as a Symbol or String.")
			end

			if normalized_name == "script"
				raise ArgumentError.new("You can’t use the `<script>` tag from the `tag` method. Use `unsafe_tag` instead, but be careful if using user input.")
			end

			if registered_elements[normalized_name]
				public_send(normalized_name, ...)
			else
				raise ArgumentError.new("Unknown tag: #{normalized_name}")
			end
		end

		def unsafe_tag(name, ...)
			normalized_name = case name
				when Symbol then name.name.downcase
				when String then name.downcase
				else raise ArgumentError.new("Expected the tag name as a Symbol or String.")
			end

			if registered_elements[normalized_name]
				public_send(normalized_name, ...)
			else
				raise ArgumentError.new("Unknown tag: #{normalized_name}")
			end
		end

		private

		# @api private
		def flush
			return if @_context.capturing

			buffer = @_context.buffer
			@_buffer << buffer.dup
			buffer.clear
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
		def render(renderable, &)
			case renderable
			when Phlex::SGML
				renderable.call(@_buffer, context: @_context, view_context: @_view_context, parent: self, &)
			when Class
				if renderable < Phlex::SGML
					renderable.new.call(@_buffer, context: @_context, view_context: @_view_context, parent: self, &)
				end
			when Enumerable
				renderable.each { |r| render(r, &) }
			when Proc, Method
				if renderable.arity == 0
					yield_content_with_no_args(&renderable)
				else
					yield_content(&renderable)
				end
			when String
				plain(renderable)
			else
				raise ArgumentError.new("You can't render a #{renderable.inspect}.")
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

			buffer = @_context.buffer

			original_length = buffer.bytesize
			content = yield(self)
			__text__(content) if original_length == buffer.bytesize

			nil
		end

		# Same as {#yield_content} but yields no arguments.
		# @yield Yields the block with no arguments.
		def yield_content_with_no_args
			return unless block_given?

			buffer = @_context.buffer

			original_length = buffer.bytesize
			content = yield
			__text__(content) if original_length == buffer.bytesize

			nil
		end

		# Same as {#yield_content} but accepts a splat of arguments to yield. This is slightly slower than {#yield_content}.
		# @yield [*args] Yields the given arguments.
		# @return [nil]
		def yield_content_with_args(*)
			return unless block_given?

			buffer = @_context.buffer

			original_length = buffer.bytesize
			content = yield(*)
			__text__(content) if original_length == buffer.bytesize

			nil
		end

		# Performs the same task as the public method #plain, but does not raise an error if an unformattable object is passed
		# @api private
		def __text__(content)
			context = @_context
			return true if context.fragments && !context.in_target_fragment

			case content
			when String
				@_context.buffer << Phlex::Escape.html_escape(content)
			when Symbol
				@_context.buffer << Phlex::Escape.html_escape(content.name)
			when nil
				nil
			else
				if (formatted_object = format_object(content))
					@_context.buffer << Phlex::Escape.html_escape(formatted_object)
				else
					return false
				end
			end

			true
		end

		# @api private
		def __attributes__(attributes, buffer = +"")
			attributes.each do |k, v|
				next unless v

				name = case k
					when String then k
					when Symbol then k.name.tr("_", "-")
					else raise ArgumentError.new("Attribute keys should be Strings or Symbols.")
				end

				lower_name = name.downcase
				next if lower_name == "href" && v.to_s.downcase.delete("^a-z:").start_with?("javascript:")

				# Detect unsafe attribute names. Attribute names are considered unsafe if they match an event attribute or include unsafe characters.
				if HTML::EVENT_ATTRIBUTES.include?(lower_name.delete("^a-z-")) || name.match?(/[<>&"']/)
					raise ArgumentError.new("Unsafe attribute name detected: #{k}.")
				end

				if lower_name.to_sym == :id && k != :id
					raise ArgumentError.new(":id attribute should only be passed as a lowercase symbol.")
				end

				case v
				when true
					buffer << " " << name
				when String
					buffer << " " << name << '="' << v.gsub('"', "&quot;") << '"'
				when Symbol
					buffer << " " << name << '="' << v.name.gsub('"', "&quot;") << '"'
				when Integer, Float
					buffer << " " << name << '="' << v.to_s << '"'
				when Hash
					case k
					when :class
						buffer << " " << name << '="' << __classes__(v).gsub('"', "&quot;") << '"'
					when :style
						buffer << " " << name << '="' << __styles__(v).gsub('"', "&quot;") << '"'
					else
						__nested_attributes__(v, "#{name}-", buffer)
					end
				when Array
					value = case k
					when :class
						__classes__(v)
					when :style
						__styles__(v)
					else
						__nested_tokens__(v)
					end

					buffer << " " << name << '="' << value.gsub('"', "&quot;") << '"'
				when Set
					buffer << " " << name << '="' << __nested_tokens__(v.to_a) << '"'
				else
					value = if v.respond_to?(:to_phlex_attribute_value)
						v.to_phlex_attribute_value
					elsif v.respond_to?(:to_str)
						v.to_str
					else
						v.to_s
					end

					buffer << " " << name << '="' << value.gsub('"', "&quot;") << '"'
				end
			end

			buffer
		end

		# @api private
		#
		# Provides the nested-attributes case for serializing out attributes.
		# This allows us to skip many of the checks the `__attributes__` method must perform.
		def __nested_attributes__(attributes, base_name, buffer = +"")
			attributes.each do |k, v|
				next unless v

				name = case k
					when String then k
					when Symbol then k.name.tr("_", "-")
					else raise ArgumentError.new("Attribute keys should be Strings or Symbols")
				end

				case v
				when true
					buffer << " " << base_name << name
				when String
					buffer << " " << base_name << name << '="' << v.gsub('"', "&quot;") << '"'
				when Symbol
					buffer << " " << base_name << name << '="' << v.name.gsub('"', "&quot;") << '"'
				when Integer, Float
					buffer << " " << base_name << name << '="' << v.to_s << '"'
				when Hash
					__nested_attributes__(v, "#{base_name}-#{name}-", buffer)
				when Array
					buffer << " " << base_name << name << '="' << __nested_tokens__(v) << '"'
				when Set
					buffer << " " << base_name << name << '="' << __nested_tokens__(v.to_a) << '"'
				else
					value = if v.respond_to?(:to_phlex_attribute_value)
						v.to_phlex_attribute_value
					elsif v.respond_to?(:to_str)
						v.to_str
					else
						v.to_s
					end
					buffer << " " << base_name << name << '="' << value.gsub('"', "&quot;") << '"'
				end

				buffer
			end
		end

		# @api private
		def __nested_tokens__(tokens)
			buffer = +""

			i, length = 0, tokens.length

			while i < length
				token = tokens[i]

				case token
				when String
					if i > 0
						buffer << " " << token
					else
						buffer << token
					end
				when Symbol
					if i > 0
						buffer << " " << token.name
					else
						buffer << token.name
					end
				when nil
					# Do nothing
				else
					if i > 0
						buffer << " " << token.to_s
					else
						buffer << token.to_s
					end
				end

				i += 1
			end

			buffer.gsub!('"', "&quot;")
			buffer
		end

		# @api private
		def __classes__(c)
			case c
			when String
				c
			when Symbol
				c.name
			when Array, Set
				c.filter_map { |c| __classes__(c) }.join(" ")
			when Hash
				c.filter_map { |c, add|
					next unless add
					case c
						when String then c
						when Symbol then c.name.tr("_", "-").delete_suffix("?")
						else raise ArgumentError.new("Class keys should be Strings or Symbols.")
					end
				}.join(" ")
			when nil, false
				nil
			else
				if c.respond_to?(:to_phlex_attribute_value)
					c.to_phlex_attribute_value
				elsif c.respond_to?(:to_str)
					c.to_str
				else
					c.to_s
				end
			end
		end

		# @api private
		def __styles__(s)
			style = case s
			when String
				s
			when Symbol
				s.name
			when Integer, Float
				s.to_s
			when Array, Set
				s.filter_map { |s| __styles__(s) }.join
			when Hash
				buffer = +""
				s.each do |k, v|
					prop = case k
						when String then k
						when Symbol then k.name.tr("_", "-")
						else raise ArgumentError.new("Style keys should be Strings or Symbols.")
					end

					value = __styles__(v)

					if value
						buffer << prop << ":" << value
					end
				end
				buffer
			when nil, false
				return nil
			else
				if s.respond_to?(:to_phlex_attribute_value)
					s.to_phlex_attribute_value
				elsif s.respond_to?(:to_str)
					s.to_str
				else
					s.to_s
				end
			end

			style.end_with?(";") ? style : "#{style};"
		end
	end
end
