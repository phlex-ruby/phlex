# frozen_string_literal: true
module Phlex
  class Component
    class DSL
      include Phlex::Context

      def initialize(component)
        @component = component
        @_target = component.instance_variable_get(:@_target)
      end

      private

      def phlex_block(&block)
        return block if block.binding.receiver.is_a?(Phlex::Block)
        Phlex::Block.new(@component.instance_variable_get(:@_parent), &block)
      end
    end
  end
end
