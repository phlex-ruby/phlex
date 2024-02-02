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
		@registered_elements ||= Phlex::ConcurrentMap.new
	end

	# Register a custom element. This macro defines an element method for the current class and descendents only. There is no global element registry.
	# @param method_name [Symbol]
	# @param tag [String] the name of the tag, otherwise this will be the method name with underscores replaced with dashes.
	# @return [Symbol] the name of the method created
	# @note The methods defined by this macro depend on other methods from {SGML} so they should always be mixed into an {HTML} or {SVG} component.
	# @example Register the custom element `<trix-editor>`
	# 	register_element :trix_editor
	def register_element(method_name, tag: nil, deprecated: false)
		tag ||= method_name.name.tr("_", "-")

		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes, &block)
				target = @_context.target

				if attributes.length > 0 # with attributes
					if block # with content block
						target << "<#{tag}" << (Phlex::CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
						yield_content(&block)
						target << "</#{tag}>"
					else # without content block
						target << "<#{tag}" << (Phlex::CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << "></#{tag}>"
					end
				else # without attributes
					if block # with content block
						target << "<#{tag}>"
						yield_content(&block)
						target << "</#{tag}>"
					else # without content block
						target << "<#{tag}></#{tag}>"
					end
				end

				#{'flush' if tag == 'head'}

				nil
			end

			alias_method :_#{method_name}, :#{method_name}
		RUBY

		registered_elements[method_name] = tag

		method_name
	end

	# @api private
	def register_void_element(method_name, tag: method_name.name.tr("_", "-"), deprecated: false)
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{method_name}(**attributes)
				target = @_context.target

				if attributes.length > 0 # with attributes
					target << "<#{tag}" << (Phlex::CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
				else # without attributes
					target << "<#{tag}>"
				end

				nil
			end

			alias_method :_#{method_name}, :#{method_name}
		RUBY

		registered_elements[method_name] = tag

		method_name
	end
end
