# frozen_string_literal: true

# **Standard Generalized Markup Language** for behaviour common to {HTML} and {SVG}.
class Phlex::SGML
	UNSAFE_ATTRIBUTES = Set.new(%w[srcdoc sandbox http-equiv]).freeze
	REF_ATTRIBUTES = Set.new(%w[href src action formaction lowsrc dynsrc background ping]).freeze

	autoload :Elements, "phlex/sgml/elements"
	autoload :SafeObject, "phlex/sgml/safe_object"
	autoload :SafeValue, "phlex/sgml/safe_value"
	autoload :Renderer, "phlex/sgml/renderer"

	include Phlex::Helpers

	class << self
		# Render the view to a String. Arguments are delegated to {.new}.
		def call(...)
			new(...).call
		end

		# Create a new instance of the component.
		# @note The block will not be delegated {#initialize}. Instead, it will be sent to {#template} when rendering.
		def new(*a, **k, &block)
			if block
				object = super(*a, **k, &nil)
				object.instance_exec { @_content_block = block }
				object
			else
				super
			end
		end
	end

	def view_template
		if block_given?
			yield
		else
			plain "Phlex Warning: Your `#{self.class.name}` class doesn't define a `view_template` method. If you are upgrading to Phlex 2.x make sure to rename your `template` method to `view_template`. See: https://beta.phlex.fun/guides/v2-upgrade.html"
		end
	end

	def to_proc
		proc { |c| c.render(self) }
	end

	def call(buffer = +"", context: {}, view_context: nil, parent: nil, fragments: nil, &block)
		@_buffer = buffer
		@_context = phlex_context = parent&.__context__ || Phlex::SGML::Renderer.new(user_context: context, view_context:)
		@_parent = parent

		raise Phlex::DoubleRenderError.new("You can't render a #{self.class.name} more than once.") if @_rendered
		@_rendered = true

		if fragments
			phlex_context.target_fragments(fragments)
		end

		block ||= @_content_block

		return "" unless render?

		Thread.current[:__phlex_component__] = [self, Fiber.current.object_id].freeze

		phlex_context.around_render do
			before_template(&block)

			around_template do
				if block
					view_template do |*args|
						if args.length > 0
							__yield_content_with_args__(*args, &block)
						else
							__yield_content__(&block)
						end
					end
				else
					view_template
				end
			end

			after_template(&block)
		end

		unless parent
			buffer << phlex_context.buffer
		end
	ensure
		Thread.current[:__phlex_component__] = [parent, Fiber.current.object_id].freeze
	end

	protected def __context__ = @_context

	def context
		@_context.user_context
	end

	# Output plain text.
	def plain(content)
		unless __text__(content)
			raise Phlex::ArgumentError.new("You've passed an object to plain that is not handled by format_object. See https://rubydoc.info/gems/phlex/Phlex/SGML#format_object-instance_method for more information")
		end

		nil
	end

	# Output a single space character. If a block is given, a space will be output before and after the block.
	def whitespace(&)
		context = @_context
		return unless context.should_render?

		buffer = context.buffer

		buffer << " "

		if block_given?
			__yield_content__(&)
			buffer << " "
		end

		nil
	end

	# Wrap the output in an HTML comment.
	#
	# [MDN Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Comments)
	def comment(&)
		context = @_context
		return unless context.should_render?

		buffer = context.buffer

		buffer << "<!-- "
		__yield_content__(&)
		buffer << " -->"

		nil
	end

	# Output the given safe object as-is. You may need to use `safe` to mark a string as a safe object.
	def raw(content)
		case content
		when Phlex::SGML::SafeObject
			context = @_context
			return unless context.should_render?

			context.buffer << content.to_s
		when nil, "" # do nothing
		else
			raise Phlex::ArgumentError.new("You passed an unsafe object to `raw`.")
		end

		nil
	end

	# Capture the output of the block and returns it as a string.
	def capture(*args, &block)
		return "" unless block

		if args.length > 0
			@_context.capturing_into(+"") { __yield_content_with_args__(*args, &block) }
		else
			@_context.capturing_into(+"") { __yield_content__(&block) }
		end
	end

	# Define a named fragment that can be selectively rendered.
	def fragment(name)
		context = @_context
		context.begin_fragment(name)
		yield
		context.end_fragment(name)
		nil
	end

	# Mark the given string as safe for HTML output.
	def safe(value)
		case value
		when String
			Phlex::SGML::SafeValue.new(value)
		else
			raise Phlex::ArgumentError.new("Expected a String.")
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
			renderable.call(@_buffer, parent: self, &)
		when Class
			if renderable < Phlex::SGML
				renderable.new.call(@_buffer, parent: self, &)
			end
		when Enumerable
			renderable.each { |r| render(r, &) }
		when Proc, Method
			if renderable.arity == 0
				__yield_content_with_no_args__(&renderable)
			else
				__yield_content__(&renderable)
			end
		when String
			plain(renderable)
		when nil
			__yield_content__(&) if block_given?
		else
			raise Phlex::ArgumentError.new("You can't render a #{renderable.inspect}.")
		end

		nil
	end

	# Cache a block of content.
	#
	# ```ruby
	# @products.each do |product|
	#   cache product do
	#     h1 { product.name }
	#   end
	# end
	# ```
	def cache(*cache_key, **, &content)
		context = @_context

		location = caller_locations(1, 1)[0]

		full_key = [
			Phlex::DEPLOY_KEY,   # invalidates the key when deploying new code in case of changes
			self.class.name,     # prevents collisions between classes
			location.base_label, # prevents collisions between different methods
			location.lineno,     # prevents collisions between different lines
			cache_key,           # allows for custom cache keys
		].freeze

		low_level_cache(full_key, **, &content)
	end

	# Cache a block of content where you control the entire cache key.
	# If you really know what you’re doing and want to take full control
	# and responsibility for the cache key, use this method.
	#
	# ```ruby
	# low_level_cache([Commonmarker::VERSION, Digest::MD5.hexdigest(@content)]) do
	#   markdown(@content)
	# end
	# ```
	#
	# Note: To allow you more control, this method does not take a splat of cache keys.
	# If you need to pass multiple cache keys, you should pass an array.
	def low_level_cache(cache_key, **options, &content)
		context = @_context

		cached_buffer, fragment_map = cache_store.fetch(cache_key, **options) { context.caching(&content) }

		if context.should_render?
			fragment_map.each do |fragment_name, (offset, length, nested_fragments)|
				context.record_fragment(fragment_name, offset, length, nested_fragments)
			end
			context.buffer << cached_buffer
		else
			fragment_map.each do |fragment_name, (offset, length, nested_fragments)|
				if context.fragments.include?(fragment_name)
					context.fragments.delete(fragment_name)
					context.fragments.subtract(nested_fragments)
					context.buffer << cached_buffer.byteslice(offset, length)
				end
			end
		end
	end

	# Points to the cache store used by this component.
	# By default, it points to `Phlex::NullCacheStore`, which does no caching.
	# Override this method to use a different cache store.
	def cache_store
		Phlex::NullCacheStore
	end

	private

	def vanish(*args)
		return unless block_given?

		if args.length > 0
			@_context.capturing_into(Phlex::Vanish) { yield(*args) }
		else
			@_context.capturing_into(Phlex::Vanish) { yield(self) }
		end

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
		yield
		nil
	end

	def before_template
		nil
	end

	def after_template
		nil
	end

	def __yield_content__
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield(self)
		__implicit_output__(content) if original_length == buffer.bytesize

		nil
	end

	def __yield_content_with_no_args__
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield
		__implicit_output__(content) if original_length == buffer.bytesize

		nil
	end

	def __yield_content_with_args__(*a)
		return unless block_given?

		buffer = @_context.buffer

		original_length = buffer.bytesize
		content = yield(*a)
		__implicit_output__(content) if original_length == buffer.bytesize

		nil
	end

	def __implicit_output__(content)
		context = @_context
		return true unless context.should_render?

		case content
		when Phlex::SGML::SafeObject
			context.buffer << content.to_s
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

	# same as __implicit_output__ but escapes even `safe` objects
	def __text__(content)
		context = @_context
		return true unless context.should_render?

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

			value = case v
			when true
				true
			when String
				v.gsub('"', "&quot;")
			when Symbol
				v.name.tr("_", "-").gsub('"', "&quot;")
			when Integer, Float
				v.to_s
			when Hash
				case k
				when :style
					__styles__(v).gsub('"', "&quot;")
				else
					__nested_attributes__(v, "#{name}-", buffer)
				end
			when Array
				case k
				when :style
					__styles__(v).gsub('"', "&quot;")
				else
					__nested_tokens__(v)
				end
			when Set
				case k
				when :style
					__styles__(v).gsub('"', "&quot;")
				else
					__nested_tokens__(v.to_a)
				end
			when Phlex::SGML::SafeObject
				v.to_s.gsub('"', "&quot;")
			else
				raise Phlex::ArgumentError.new("Invalid attribute value for #{k}: #{v.inspect}.")
			end

			lower_name = name.downcase

			unless Phlex::SGML::SafeObject === v
				normalized_name = lower_name.delete("^a-z-")

				if value != true && REF_ATTRIBUTES.include?(normalized_name)
					case value
					when String
						if value.downcase.delete("^a-z:").start_with?("javascript:")
							# We just ignore these because they were likely not specified by the developer.
							next
						end
					else
						raise Phlex::ArgumentError.new("Invalid attribute value for #{k}: #{v.inspect}.")
					end
				end

				if normalized_name.bytesize > 2 && normalized_name.start_with?("on") && !normalized_name.include?("-")
					raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
				end

				if UNSAFE_ATTRIBUTES.include?(normalized_name)
					raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
				end
			end

			if name.match?(/[<>&"']/)
				raise Phlex::ArgumentError.new("Unsafe attribute name detected: #{k}.")
			end

			if lower_name.to_sym == :id && k != :id
				raise Phlex::ArgumentError.new(":id attribute should only be passed as a lowercase symbol.")
			end

			case value
			when true
				buffer << " " << name
			when String
				buffer << " " << name << '="' << value << '"'
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
			when Array
				if token.length > 0
					if i > 0
						buffer << " " << __nested_tokens__(token)
					else
						buffer << __nested_tokens__(token)
					end
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

	private_class_method def self.method_added(method_name)
		if method_name == :view_template
			location = instance_method(method_name).source_location[0]

			if location[0] in "/" | "."
				Phlex.__expand_attribute_cache__(location)
			end
		else
			super
		end
	end
end
