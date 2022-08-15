module Components
  class Example < Phlex::Component
    class DSL
      def initialize
        @tabs = {}
      end

      def tab(name, code)
        @tabs[name] = code
      end

      def execute(value)
        @execute = value
      end
    end

    def initialize
      @dsl = DSL.new
    end

    def template(&)
      yield(@dsl)

      component Tabs do |t|
        tabs.each do |name, code|
          t.tab name do
            component CodeBlock, code, syntax: :ruby
          end
        end

        pretty_output.tap do |pretty_output|
          t.tab "HTML Output" do
            component CodeBlock, pretty_output, syntax: :html
          end
        end
      end
    end

    private

    def pretty_output
      HtmlBeautifier.beautify(output, new_lines: true)
    end

    def output
      return @output if defined? @output

      tabs.each_value do |code|
        sandbox.instance_eval(code)
      end

      @output = sandbox.instance_eval(@dsl.instance_variable_get(:@execute))
    end

    def tabs
      @dsl.instance_variable_get(:@tabs)
    end

    def sandbox
      @sandbox ||= Module.new
    end
  end
end
