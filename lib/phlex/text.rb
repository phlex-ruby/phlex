module Phlex
  class Text
    include Callable

    def initialize(content)
      @content = content
    end

    def call
      Phlex.html_escape(@content)
    end
  end
end
