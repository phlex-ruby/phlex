# frozen_string_literal: true

module Phlex
  class Component
    include Node

    def initialize(&block)
      Context.new(self, block).call(&template)
    end
  end
end
