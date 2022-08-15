module Components
  class Tabs < Phlex::Component
    class DSL
      def initialize
        @tabs = {}.compare_by_identity
      end

      def tab(name, &block)
        @tabs[name] = block
      end
    end

    def initialize
      @dsl = DSL.new
    end

    def template(&)
      yield(@dsl)

      div class: "tabs flex flex-wrap relative my-5" do
        number = 1

        tabs.each do |name, content|
          component Tab, name:, content:, checked: (number == 1)
          number += 1
        end
      end
    end

    private

    def tabs
      @dsl.instance_variable_get(:@tabs)
    end
  end
end
