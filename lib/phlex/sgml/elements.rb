# frozen_string_literal: true

module Phlex::SGML::Elements
	def __registered_elements__
		@__registered_elements__ ||= {}
	end

	def register_element(method_name, tag: method_name.name.tr("_", "-"))
		class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes)
				state = @_state
				buffer = state.buffer
				block_given = block_given?

				unless state.should_render?
					yield(self) if block_given
					return nil
				end

				if attributes.length > 0 # with attributes
					if block_given # with content block
						buffer << "<#{tag}"
						begin
							buffer << (Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes))
						ensure
							buffer << ">"
						end

						begin
							original_length = buffer.bytesize
							content = yield(self)
							if original_length == buffer.bytesize
								case content
								when ::Phlex::SGML::SafeObject
									buffer << content.to_s
								when String
									buffer << ::Phlex::Escape.html_escape(content)
								when Symbol
									buffer << ::Phlex::Escape.html_escape(content.name)
								when nil
									nil
								else
									if (formatted_object = format_object(content))
										buffer << ::Phlex::Escape.html_escape(formatted_object)
									end
								end
							end
						ensure
							buffer << "</#{tag}>"
						end
					else # without content
						buffer << "<#{tag}"
						begin
							buffer << (::Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes))
						ensure
							buffer << "></#{tag}>"
						end
					end
				else # without attributes
					if block_given # with content block
						buffer << "<#{tag}>"

						begin
							original_length = buffer.bytesize
							content = yield(self)
							if original_length == buffer.bytesize
								case content
								when ::Phlex::SGML::SafeObject
									buffer << content.to_s
								when String
									buffer << ::Phlex::Escape.html_escape(content)
								when Symbol
									buffer << ::Phlex::Escape.html_escape(content.name)
								when nil
									nil
								else
									if (formatted_object = format_object(content))
										buffer << ::Phlex::Escape.html_escape(formatted_object)
									end
								end
							end
						ensure
							buffer << "</#{tag}>"
						end
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
				state = @_state

				return unless state.should_render?

				buffer = state.buffer

				if attributes.length > 0 # with attributes
					buffer << "<#{tag}"
					begin
						buffer << (::Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes))
					ensure
						buffer << ">"
					end
				else # without attributes
					buffer << "<#{tag}>"
				end

				nil
			end
		RUBY

		__registered_elements__[method_name] = tag

		method_name
	end
end
