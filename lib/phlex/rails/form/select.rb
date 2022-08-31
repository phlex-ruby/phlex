module Phlex
  module Rails
    class Form
      class Select < Phlex::Component
        def initialize(name, value:, **attributes)
          @name = name
          @value = value
          @attributes = attributes
        end

        def template(&)
          select name: @name, **@attributes do
            yield(self)
          end
        end

        def option(name, value:, selected: (@value == value), **attributes)
          super(name, value: value, selected: selected, **attributes)
        end
      end
    end
  end
end
