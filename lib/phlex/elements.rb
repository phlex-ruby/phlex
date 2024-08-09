# frozen_string_literal: true

# Extending this module provides the {register_element} macro for registering your own custom elements. It's already extended by {HTML} and {SVG}.
# @example
# 	module MyCustomElements
# 		extend Phlex::Elements
#
# 		register_element :trix_editor
# 	end
#
# 	class MyComponent < Phlex::HTML
# 		include MyCustomElements
#
# 		def view_template
# 			trix_editor
# 		end
# 	end
module Phlex::Elements
	# @api private
	def registered_elements
		@registered_elements ||= {}
	end

	# Register a custom element. This macro defines an element method for the current class and descendents only. There is no global element registry.
	# @param method_name [Symbol]
	# @param tag [String] the name of the tag, otherwise this will be the method name with underscores replaced with dashes.
	# @return [Symbol] the name of the method created
	# @note The methods defined by this macro depend on other methods from {SGML} so they should always be mixed into an {HTML} or {SVG} component.
	# @example Register the custom element `<trix-editor>`
	# 	register_element :trix_editor
	def register_element(method_name, tag: method_name.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes, &block)
				context = @_context
				buffer = context.buffer
				fragment = context.fragments
				target_found = false

				if fragment
					return if fragment.length == 0 # we found all our fragments already

					id = attributes[:id]

					if !context.in_target_fragment
					  if fragment[id]
							context.begin_target(id)
							target_found = true
						else
							yield(self) if block
							return nil
						end
					end
				end

				if attributes.length > 0 # with attributes
					if block # with content block
						buffer << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << ">"
						yield_content(&block)
						buffer << "</#{tag}>"
					else # without content block
						buffer << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << "></#{tag}>"
					end
				else # without attributes
					if block # with content block
						buffer << "<#{tag}>"
						yield_content(&block)
						buffer << "</#{tag}>"
					else # without content block
						buffer << "<#{tag}></#{tag}>"
					end
				end

				#{'flush' if tag == 'head'}

				context.end_target if target_found

				nil
			end

			alias_method :_#{method_name}, :#{method_name}
		RUBY

		registered_elements[method_name] = tag

		method_name
	end

	# @api private
	def register_void_element(method_name, tag: method_name.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes)
				context = @_context
				buffer = context.buffer
				fragment = context.fragments

				if fragment
					return if fragment.length == 0 # we found all our fragments already

					id = attributes[:id]

					if !context.in_target_fragment
					  if fragment[id]
							context.begin_target(id)
							target_found = true
						else
							return nil
						end
					end
				end

				if attributes.length > 0 # with attributes
					buffer << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes] ||= __attributes__(attributes)) << ">"
				else # without attributes
					buffer << "<#{tag}>"
				end

				context.end_target if target_found

				nil
			end

			alias_method :_#{method_name}, :#{method_name}
		RUBY

		registered_elements[method_name] = tag

		method_name
	end
end
