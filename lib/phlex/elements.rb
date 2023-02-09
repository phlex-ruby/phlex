# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex
	module Elements
		def register_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(**attributes, &block)
          if attributes.length > 0
            if block_given?
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || __attributes__(**attributes)) << ">"
              yield_content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || __attributes__(**attributes)) << "></#{tag}>"
            end
          else
            if block_given?
              @_target << "<#{tag}>"
              yield_content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}></#{tag}>"
            end
          end

          nil
        end

				alias_method :_#{element}, :#{element}
			RUBY

			Phlex::HTML::STANDARD_ELEMENTS[element] = tag
		end

		def register_void_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(**attributes)
          if attributes.length > 0
            @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || __attributes__(**attributes)) << ">"
          else
            @_target << "<#{tag}>"
          end

          nil
        end

				alias_method :_#{element}, :#{element}
			RUBY

			Phlex::HTML::VOID_ELEMENTS[element] = tag
		end
	end
end
