# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex
	module Elements
		def register_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(content = nil, **attributes, &block)
					if content
						raise ArgumentError, %(👋 You can no longer pass content to #{element} as a positional argument.\n Instead, you can pass it as a block, e.g. #{element} { "Hello" })
					end

          if attributes.length > 0
            if block_given?
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(**attributes)) << ">"
              yield_content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(**attributes)) << "></#{tag}>"
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
			RUBY
		end

		def register_void_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(**attributes)
          if attributes.length > 0
            @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(**attributes)) << ">"
          else
            @_target << "<#{tag}>"
          end

          nil
        end
			RUBY
		end
	end
end
