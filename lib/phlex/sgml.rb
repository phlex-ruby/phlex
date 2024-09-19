# frozen_string_literal: true

# **Standard Generalized Markup Language** for behaviour common to {HTML} and {SVG}.
class Phlex::SGML
	autoload :Elements, "phlex/sgml/elements"
	autoload :SafeObject, "phlex/sgml/safe_object"
	autoload :SafeValue, "phlex/sgml/safe_value"

	include Phlex::Helpers

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

		def __element_method__?(method_name)
			if instance_methods.include?(method_name)
				owner = instance_method(method_name).owner

				if Phlex::SGML::Elements === owner && owner.__registered_elements__[method_name]
					true
				else
					false
				end
			else
				false
			end
		end
	end

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
			raise Phlex::ArgumentError.new("Expected an asynchronous task / promise.")
		end
	end

	def to_proc
		proc { |c| c.render(self) }
	end

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
					if Phlex::DeferredRender === self
						vanish(self, &block)
						view_template
					else
						view_template do |*args|
							if args.length > 0
								__yield_content_with_args__(*args, &block)
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

	def context
		@_context.user_context
	end

	def plain(content)
		unless __text__(content)
			raise Phlex::ArgumentError.new("You've passed an object to plain that is not handled by format_object. See https://rubydoc.info/gems/phlex/Phlex/SGML#format_object-instance_method for more information")
		end

		nil
	end

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

	def comment(&)
		context = @_context
		return if context.fragments && !context.in_target_fragment

		buffer = context.buffer

		buffer << "<!-- "
		yield_content(&)
		buffer << " -->"

		nil
	end

	def raw(content)
		case content
		when Phlex::SGML::SafeObject
			context = @_context
			return if context.fragments && !context.in_target_fragment

			context.buffer << content.to_s
		when nil, "" # do nothing
		else
			raise Phlex::ArgumentError.new("You passed an unsafe object to `raw`.")
		end

		nil
	end

	def capture(*args, &block)
		return "" unless block

		if args.length > 0
			@_context.capturing_into(+"") { __yield_content_with_args__(*args, &block) }
		else
			@_context.capturing_into(+"") { yield_content(&block) }
		end
	end

	def tag(name, ...)
		normalized_name = case name
			when Symbol then name.name.downcase
			when String then name.downcase
			else raise Phlex::ArgumentError.new("Expected the tag name as a Symbol or String.")
		end

		if normalized_name == "script"
			raise Phlex::ArgumentError.new("You can’t use the `<script>` tag from the `tag` method. Use `unsafe_tag` instead, but be careful if using user input.")
		end

		if __registered_elements__[normalized_name]
			public_send(normalized_name, ...)
		else
			raise Phlex::ArgumentError.new("Unknown tag: #{normalized_name}")
		end
	end

	def safe(value)
		case value
		when String
			Phlex::SGML::SafeValue.new(value)
		when Symbol
			Phlex::SGML::SafeValue.new(value.to_s)
		else
			raise Phlex::ArgumentError.new("Expected a String or Symbol.")
		end
	end

	alias_method :🦺, :safe

	def flush
		return if @_context.capturing

		buffer = @_context.buffer
		@_buffer << buffer.dup
		buffer.clear
	end

	def render(renderable = nil, &)
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
				__yield_content_with_no_args__(&renderable)
			else
				yield_content(&renderable)
			end
		when String
			plain(renderable)
		when nil
			yield_content(&) if block_given?
		else
			raise Phlex::ArgumentError.new("You can't render a #{renderable.inspect}.")
		end

		nil
	end

	private

	def vanish(*args)
		return unless block_given?

		@_context.capturing_into(Phlex::BlackHole) { yield(*args) }

		nil
	end

	def render?
		true
	end

	def format_object(object)
		case object
		when Float, Integer
			object.to_s
		end
	end

	def around_template
		before_template
		yield
		after_template

		nil
	end

	def before_template
		nil
	end

	def after_template
		nil
	end

	def yield_content
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield(self)
		__text__(content) if original_length == buffer.bytesize

		nil
	end

	def __yield_content_with_no_args__
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield
		__text__(content) if original_length == buffer.bytesize

		nil
	end

	def __yield_content_with_args__(*)
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield(*)
		__text__(content) if original_length == buffer.bytesize

		nil
	end

	def __text__(content)
		context = @_context
		return true if context.fragments && !context.in_target_fragment

		case content
		when String
			context.buffer << Phlex::Escape.html_escape(content)
		when Symbol
			context.buffer << Phlex::Escape.html_escape(content.name)
		when nil
			nil
		else
			if (formatted_object = format_object(content))
				context.buffer << Phlex::Escape.html_escape(formatted_object)
			else
				return false
			end
		end

		true
	end

	def __attributes__(attributes, buffer = +"")
		attributes.each do |k, v|
			next unless v

			name = case k
				when String then k
				when Symbol then k.name.tr("_", "-")
				else raise Phlex::ArgumentError.new("Attribute keys should be Strings or Symbols.")
			end

			lower_name = name.downcase

			unless Phlex::SGML::SafeObject === v
				if lower_name == "href" && v.to_s.downcase.delete("^a-z:").start_with?("javascript:")
					next
				end

				# Detect unsafe attribute names. Attribute names are considered unsafe if they match an event attribute or include unsafe characters.
				if Phlex::HTML::UNSAFE_ATTRIBUTES.include?(lower_name.delete("^a-z-"))
					raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
				end
			end

			if name.match?(/[<>&"']/)
				raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
			end

			if lower_name.to_sym == :id && k != :id
				raise Phlex::ArgumentError.new(":id attribute should only be passed as a lowercase symbol.")
			end

			case v
			when true
				buffer << " " << name
			when String
				buffer << " " << name << '="' << v.gsub('"', "&quot;") << '"'
			when Symbol
				buffer << " " << name << '="' << v.name.tr("_", "-").gsub('"', "&quot;") << '"'
			when Integer, Float
				buffer << " " << name << '="' << v.to_s << '"'
			when Hash
				case k
				when :style
					buffer << " " << name << '="' << __styles__(v).gsub('"', "&quot;") << '"'
				else
					__nested_attributes__(v, "#{name}-", buffer)
				end
			when Array
				case k
				when :style
					buffer << " " << name << '="' << __styles__(v).gsub('"', "&quot;") << '"'
				else
					buffer << " " << name << '="' << __nested_tokens__(v) << '"'
				end
			when Set
				case k
				when :style
					buffer << " " << name << '="' << __styles__(v).gsub('"', "&quot;") << '"'
				else
					buffer << " " << name << '="' << __nested_tokens__(v.to_a) << '"'
				end
			when Phlex::SGML::SafeObject
				buffer << " " << name << '="' << v.to_s.gsub('"', "&quot;") << '"'
			else
				raise Phlex::ArgumentError.new("Invalid attribute value for #{k}: #{v.inspect}.")
			end
		end

		buffer
	end

	# Provides the nested-attributes case for serializing out attributes.
	# This allows us to skip many of the checks the `__attributes__` method must perform.
	def __nested_attributes__(attributes, base_name, buffer = +"")
		attributes.each do |k, v|
			next unless v

			name = case k
				when String then k
				when Symbol then k.name.tr("_", "-")
				else raise Phlex::ArgumentError.new("Attribute keys should be Strings or Symbols")
			end

			if name.match?(/[<>&"']/)
				raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
			end

			case v
			when true
				buffer << " " << base_name << name
			when String
				buffer << " " << base_name << name << '="' << v.gsub('"', "&quot;") << '"'
			when Symbol
				buffer << " " << base_name << name << '="' << v.name.tr("_", "-").gsub('"', "&quot;") << '"'
			when Integer, Float
				buffer << " " << base_name << name << '="' << v.to_s << '"'
			when Hash
				__nested_attributes__(v, "#{base_name}#{name}-", buffer)
			when Array
				buffer << " " << base_name << name << '="' << __nested_tokens__(v) << '"'
			when Set
				buffer << " " << base_name << name << '="' << __nested_tokens__(v.to_a) << '"'
			when Phlex::SGML::SafeObject
				buffer << " " << base_name << name << '="' << v.to_s.gsub('"', "&quot;") << '"'
			else
				raise Phlex::ArgumentError.new("Invalid attribute value #{v.inspect}.")
			end

			buffer
		end
	end

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
					buffer << " " << token.name.tr("_", "-")
				else
					buffer << token.name.tr("_", "-")
				end
			when Integer, Float, Phlex::SGML::SafeObject
				if i > 0
					buffer << " " << token.to_s
				else
					buffer << token.to_s
				end
			when nil
				# Do nothing
			else
				raise Phlex::ArgumentError.new("Invalid token type: #{token.class}.")
			end

			i += 1
		end

		buffer.gsub('"', "&quot;")
	end

	# Result is **unsafe**, so it should be escaped!
	def __styles__(styles)
		case styles
		when Array, Set
			styles.filter_map do |s|
				case s
				when String
					if s == "" || s.end_with?(";")
						s
					else
						"#{s};"
					end
				when Phlex::SGML::SafeObject
					value = s.to_s
					value.end_with?(";") ? value : "#{value};"
				when Hash
					next __styles__(s)
				when nil
					next nil
				else
					raise Phlex::ArgumentError.new("Invalid style: #{s.inspect}.")
				end
			end.join(" ")
		when Hash
			buffer = +""
			i = 0
			styles.each do |k, v|
				prop = case k
				when String
					k
				when Symbol
					k.name.tr("_", "-")
				else
					raise Phlex::ArgumentError.new("Style keys should be Strings or Symbols.")
				end

				value = case v
				when String
					v
				when Symbol
					v.name.tr("_", "-")
				when Integer, Float, Phlex::SGML::SafeObject
					v.to_s
				when nil
					nil
				else
					raise Phlex::ArgumentError.new("Invalid style value: #{v.inspect}")
				end

				if value
					if i == 0
						buffer << prop << ": " << value << ";"
					else
						buffer << " " << prop << ": " << value << ";"
					end
				end

				i += 1
			end

			buffer
		end
	end
end
