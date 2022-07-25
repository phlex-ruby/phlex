# frozen_string_literal: true

module Phlex
  class Text
    include Callable

    def initialize(content)
      @content = content
    end

    def call(buffer = +"")
      buffer << CGI.escape_html(@content)
    end
  end
end
