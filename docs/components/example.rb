# frozen_string_literal: true

module Components
  class Example < Phlex::Component
    def initialize
      @sandbox = Module.new
    end

    def template(&block)
      render Tabs.new do |t|
        @t = t
        yield self
      end
    end

    def tab(name, code)
      @t.tab(name) do
        render CodeBlock.new(code, syntax: :ruby)
      end

      @sandbox.instance_eval(code)
    end

    def execute(code)
      output = @sandbox.instance_eval(code)

      @t.tab("HTML Output") do
        render CodeBlock.new(HtmlBeautifier.beautify(output), syntax: :html)
      end
    end
  end
end
