module Components
  class Example < Phlex::Component
    def initialize
      @sandbox = Module.new
    end

    def template(&)
      component Tabs do |t|
        @t = t
        yield self
      end
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
  end
end
