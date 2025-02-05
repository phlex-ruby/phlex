# frozen_string_literal: true

module Phlex::SGML::Elements
	def __registered_elements__
		@__registered_elements__ ||= {}
	end

	def register_element(method_name, tag: method_name.name.tr("_", "-"))
		class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes)
				context = @_context
				buffer = context.buffer
				block_given = block_given?

				unless context.should_render?
					yield(self) if block_given
					return nil
				end

				if attributes.length > 0 # with attributes
					if block_given # with content block
						buffer << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << ">"

						original_length = buffer.bytesize
						content = yield(self)
						if original_length == buffer.bytesize
							case content
							when nil
								nil
							when String
								buffer << ::Phlex::Escape.html_escape(content)
							when Symbol
								buffer << ::Phlex::Escape.html_escape(content.name)
							when ::Phlex::SGML::SafeObject
								buffer << content.to_s
							else
								if (formatted_object = format_object(content))
									buffer << ::Phlex::Escape.html_escape(formatted_object)
								end
							end
						end

						buffer << "</#{tag}>"
					else # without content
						buffer << "<#{tag}" << (::Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << "></#{tag}>"
					end
				else # without attributes
					if block_given # with content block
						buffer << "<#{tag}>"

						original_length = buffer.bytesize
						content = yield(self)
						if original_length == buffer.bytesize
							case content
							when nil
								nil
							when String
								buffer << ::Phlex::Escape.html_escape(content)
							when Symbol
								buffer << ::Phlex::Escape.html_escape(content.name)
							when ::Phlex::SGML::SafeObject
								buffer << content.to_s
							else
								if (formatted_object = format_object(content))
									buffer << ::Phlex::Escape.html_escape(formatted_object)
								end
							end
						end

						buffer << "</#{tag}>"
					else # without content
						buffer << "<#{tag}></#{tag}>"
					end
				end

				#{'flush' if tag == 'head'}

				nil
			end
		RUBY

		__registered_elements__[method_name] = tag

		method_name
	end

	def __register_void_element__(method_name, tag: method_name.name.tr("_", "-"))
		class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes)
				context = @_context

				return unless context.should_render?

				if attributes.length > 0 # with attributes
					context.buffer << "<#{tag}" << (::Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << ">"
				else # without attributes
					context.buffer << "<#{tag}>"
				end

				nil
			end
		RUBY

		__registered_elements__[method_name] = tag

		method_name
	end
end
