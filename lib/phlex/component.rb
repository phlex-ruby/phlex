# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex
	class Component
		extend HTML
		include Renderable

		class << self
			attr_accessor :rendered_at_least_once
				end

		def call(buffer = +"", view_context: nil, parent: nil, &block)
			raise "The same component instance shouldn't be rendered twice" if rendered?

			@_rendered = true
			@_target = buffer
			@_view_context = view_context
			@_parent = parent
			@output_buffer = self

			template(&block)

			self.class.rendered_at_least_once ||= true

			buffer
		end

		def rendered?
			@_rendered ||= false
		end

		HTML::STANDARD_ELEMENTS.each do |element|
			register_element(element)
		end

		HTML::VOID_ELEMENTS.each do |element|
			register_void_element(element)
		end

		register_element :template_tag, tag: "template"

		def content(&block)
			return unless block_given?

			original_length = @_target.length
			output = yield(self)
			unchanged = (original_length == @_target.length)

			text(output) if unchanged
			nil
		end

		def text(content)
			@_target << case content
			when String then CGI.escape_html(content)
			when Symbol then CGI.escape_html(content.name)
			else CGI.escape_html(content.to_s)
			end

			nil
		end

		def whitespace
			@_target << " "
			nil
		end

		def doctype
			@_target << HTML::DOCTYPE
			nil
		end

		def raw(content)
			@_target << content
			nil
		end

		def html_safe?
			true
		end

		def safe_append=(value)
			return unless value

			@_target << case value
			when String then value
			when Symbol then value.name
			else value.to_s
			end
		end

		def append=(value)
			return unless value

			if value.html_safe?
				self.safe_append = value
			else
				@_target << case value
				when String then CGI.escape_html(value)
				when Symbol then CGI.escape_html(value.name)
				else CGI.escape_html(value.to_s)
				end
			end
		end

		def capture(&block)
			return unless block_given?

			original_buffer = @_target
			new_buffer = +""
			@_target = new_buffer

			yield

			@_target = original_buffer
			new_buffer.html_safe
		end

		def classes(*tokens, **conditional_tokens)
			{ class: self.tokens(*tokens, **conditional_tokens) }
		end

		def tokens(*tokens, **conditional_tokens)
			conditional_tokens.each do |condition, token|
				case condition
				when Symbol then next unless send(condition)
				when Proc then next unless condition.call
				else raise ArgumentError,
										"The class condition must be a Symbol or a Proc."
				end

				case token
				when Symbol then tokens << token.name
				when String then tokens << token
				when Array then tokens.concat(t)
				else raise ArgumentError,
										"Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
				end
			end

			tokens.compact.join(" ")
		end

		def _attributes(attributes, buffer: +"")
			if attributes[:href]&.start_with?(/\s*javascript/)
				attributes[:href] = attributes[:href].sub(/^\s*(javascript:)+/, "")
			end

			_build_attributes(attributes, buffer: buffer)

			unless self.class.rendered_at_least_once
				Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
			end

			buffer
		end

		def _build_attributes(attributes, buffer:)
			attributes.each do |k, v|
				next unless v

				name = case k
				when String
					k
				when Symbol
					k.name.tr("_", "-")
				else
					k.to_s
				end

				if HTML::EVENT_ATTRIBUTES[name] || name.match?(/[<>&"']/)
					raise ArgumentError, "Unsafe attribute name detected: #{k}."
				end

				case v
				when true
					buffer << " " << name
				when String
					buffer << " " << name << '="' << CGI.escape_html(v) << '"'
				when Symbol
					buffer << " " << name << '="' << CGI.escape_html(v.name) << '"'
				when Hash
					_build_attributes(v.transform_keys { "#{k}-#{_1.name.tr('_', '-')}" }, buffer: buffer)
				else
					buffer << " " << name << '="' << CGI.escape_html(v.to_s) << '"'
				end
			end

			buffer
		end
	end
end
