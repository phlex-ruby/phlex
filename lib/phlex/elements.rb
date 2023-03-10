# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Phlex::Overrides::Symbol::Name
end

module Phlex::Elements
	def registered_elements
		@registered_elements ||= Concurrent::Map.new
	end

	def register_element(element, tag: element.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{element}(**attributes, &block)
				if attributes.length > 0 # with attributes
					if block_given? # with content block
						@_context.target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
						yield_content(&block)
						@_context.target << "</#{tag}>"
					else # without content block
						@_context.target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << "></#{tag}>"
					end
				else # without attributes
					if block_given? # with content block
						@_context.target << "<#{tag}>"
						yield_content(&block)
						@_context.target << "</#{tag}>"
					else # without content block
						@_context.target << "<#{tag}></#{tag}>"
					end
				end

				nil
			end

			alias_method :_#{element}, :#{element}
		RUBY

		registered_elements[element] = tag

		element
	end

	def register_void_element(element, tag: element.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def #{element}(**attributes)
				if attributes.length > 0 # with attributes
					@_context.target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
				else # without attributes
					@_context.target << "<#{tag}>"
				end

				nil
			end

			alias_method :_#{element}, :#{element}
		RUBY

		registered_elements[element] = tag

		element
	end
end
