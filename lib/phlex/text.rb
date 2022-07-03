module Phlex
  class Text
    include Callable

    def initialize(content)
      @content = content
    end

    def call
      ERB::Util.html_escape(@content)
    end
  end
end
