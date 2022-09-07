# frozen_string_literal: true

module Components
  class CodeBlock < Phlex::Component
    FORMATTER = Rouge::Formatters::HTML.new

    def initialize(code, syntax:)
      @code = code
      @syntax = syntax
    end

    def template
      pre(class: "highlight p-5 whitespace-pre-wrap bg-stone-50") {
        _raw FORMATTER.format(
          lexer.lex(@code)
        )
      }
    end

    private

    def lexer
      Rouge::Lexer.find(@syntax)
    end
  end
end
