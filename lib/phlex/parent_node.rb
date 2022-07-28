# frozen_string_literal: true

module Phlex
  module ParentNode
    include Callable

    def children
      @_children ||= []
    end

    def call(buffer = +"")
      children.each { _1.call(buffer) }
      buffer
    end
  end
end
