# frozen_string_literal: true

module Phlex
  module ParentNode
    include Callable

    def children
      @_children ||= +""
    end

    def call(buffer = +"")
      buffer << children
    end
  end
end
