# frozen_string_literal: true

module Phlex
  class Component
    include Node, Context

    module Initializer
      def initialize(*args, assigns: [], **kwargs, &block)
        assigns.each do |k, v|
          instance_variable_get(k) || instance_variable_set(k, v)
        end

        super(*args, **kwargs)
        template(&block)
      end
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.inherited(child)
      child.prepend(Initializer)
    end

    def render_context
      @_render_context ||= self
    end

    def <<(node)
      render_context.children << node
    end

    def render(&block)
      instance_eval(&block) if block_given?
    end

    def render_tag(tag, &block)
      old_render_context = render_context.dup
      @_render_context = tag
      instance_eval(&block)
      @_render_context = old_render_context
    end
  end
end
