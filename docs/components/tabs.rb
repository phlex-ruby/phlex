module Components
  class Tabs < Phlex::Component
    class DSL < DSL
      def initialize(component)
        @index = 1
        super
      end

      def tab(name, &)
        component Tab, name:, content: phlex_block(&), checked: first?
        @index += 1
      end

      private

      def first?
        @index == 1
      end
    end

    def template(&)
      div class: "tabs flex flex-wrap relative my-5" do
        yield DSL.new(self)
      end
    end
  end
end
