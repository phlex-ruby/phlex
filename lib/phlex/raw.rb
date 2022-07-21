module Phlex
  class Raw
    include Callable

    def initialize(content)
      @content = content
    end

    def call
      @content
    end
  end
end
