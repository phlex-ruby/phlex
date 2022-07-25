# frozen_string_literal: true

module Phlex
  class Raw
    include Callable

    def initialize(content)
      @content = content
    end

    def call(buffer = +"")
      buffer << @content
    end
  end
end
