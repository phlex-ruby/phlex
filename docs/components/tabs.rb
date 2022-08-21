module Components
  class Tabs < Phlex::Component
    def initialize
      @index = 1
    end

    def template(&)
      div class: "tabs flex flex-wrap relative my-5", role: "tablist" do
        yield(self)
      end
    end

    def tab(name, &)
      render Tab.new(name:, checked: first?, &phlex_block(&))
      @index += 1
    end

    def unique_identifier
      @unique_identifier ||= SecureRandom.hex
    end

    private

    def first?
      @index == 1
    end
  end
end
