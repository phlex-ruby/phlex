# frozen_string_literal: true

module Phlex
  class Component
    include Node, Context

    module Initializer
      def initialize(*args, parent: nil, assigns: [], **kwargs, &block)
        @_parent = parent

        assigns.each do |k, v|
          instance_variable_set(k, v) unless instance_variables.include?(k)
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

    def render(*args, **kwargs, &block)
      instance_exec(*args, **kwargs, &block) if block_given?
    end

    def render_tag(tag, &block)
      old_render_context = render_context.dup
      @_render_context = tag
      instance_eval(&block)
      @_render_context = old_render_context
    end

    def method_missing(*args, **kwargs, &block)
      super unless @_parent
      @_parent.send(*args, **kwargs, &block)
    end

    def respond_to_missing?(name)
      super unless @_parent
      @_parent.respond_to?(name)
    end
  end
end
