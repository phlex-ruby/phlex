# frozen_string_literal: true

module Phlex
  class Component
    extend Tag
    include Context, Renderable

    class << self
      attr_accessor :rendered_at_least_once

      def new(*args, **kwargs, &block)
        component = super(*args, **kwargs)

        component.instance_exec do
          @_content = block
          @_rendered = false
        end

        component
      end
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def call(buffer = +"", view_context: nil, parent: nil, &block)
      raise "The same component instance shouldn't be rendered twice" if @_rendered
      @_rendered = true
      @_target = buffer
      @_view_context = view_context
      @_parent = parent

      block_given? ? template(&block) : template(&@_content)

      self.class.rendered_at_least_once ||= true
      buffer
    end

    def phlex_block(&block)
      return block if block.binding.receiver.is_a?(Phlex::Block)
      Phlex::Block.new(@_parent, &block)
    end
  end
end
