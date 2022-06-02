# frozen_string_literal: true

module Phlex
  class Component
    include Node

    def initialize(*args, **kwargs, &block)
      Context.new(self, block, *args, **kwargs).call(&self.class.template)
    end

    class << self
      def template(&block)
        if block_given?
          @template = block
        else
          @template
        end
      end
    end
  end
end
