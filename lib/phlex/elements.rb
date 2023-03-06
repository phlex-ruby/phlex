# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Phlex::Overrides::Symbol::Name
end

module Phlex::Elements
	private def slow_registered_elements
		private_instance_methods
			.lazy
			.map(&:to_s)
			.select { |m| m.start_with?("__phlex_") }
			.map { |m| m[8...-2].to_sym }
	end

	def register_element(element, tag: element.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def __phlex_#{element}__(**attributes, &block)
				if attributes.length > 0 # with attributes
					if block_given? # with content block
						@_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
						yield_content(&block)
						@_target << "</#{tag}>"
					else # without content block
						@_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << "></#{tag}>"
					end
				else # without attributes
					if block_given? # with content block
						@_target << "<#{tag}>"
						yield_content(&block)
						@_target << "</#{tag}>"
					else # without content block
						@_target << "<#{tag}></#{tag}>"
					end
				end

				nil
			end

			alias_method :_#{element}, :__phlex_#{element}__
			alias_method :#{element}, :__phlex_#{element}__
			private :__phlex_#{element}__
		RUBY

		element
	end

	def register_void_element(element, tag: element.name.tr("_", "-"))
		class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
			# frozen_string_literal: true

			def __phlex_#{element}__(**attributes)
				if attributes.length > 0 # with attributes
					@_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[respond_to?(:process_attributes) ? (attributes.hash + self.class.hash) : attributes.hash] || __attributes__(**attributes)) << ">"
				else # without attributes
					@_target << "<#{tag}>"
				end

				nil
			end

			alias_method :_#{element}, :__phlex_#{element}__
			alias_method :#{element}, :__phlex_#{element}__
			private :__phlex_#{element}__
		RUBY

		element
	end
end
