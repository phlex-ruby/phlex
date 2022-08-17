module Components
  class Tabs < Phlex::Component
    def initialize
      @index = 1
    end

    def template(&)
      div class: "tabs flex flex-wrap relative my-5" do
        yield(self)
      end
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
end
