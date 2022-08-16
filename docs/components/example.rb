module Components
  class Example < Phlex::Component
    class DSL < DSL
      def initialize(component, t)
        super(component)
        @t = t
        @sandbox = Module.new
      end

      def tab(name, code)
        @t.tab(name) do
          component CodeBlock, code, syntax: :ruby
        end

        @sandbox.instance_eval(code)
      end

      def execute(code)
        output = @sandbox.instance_eval(code)

        @t.tab("HTML Output") do
          component CodeBlock, HtmlBeautifier.beautify(output), syntax: :html
        end
      end

      private

      def beautify_html(code)
        HtmlBeautifier.beautify(output)
      end
    end

    def template(&)
      component Tabs do |t|
        yield DSL.new(self, t)
      end
    end
  end
end
