# frozen_string_literal: true

module Phlex
  class Component
    include Node, Context

    module Initializer
      def initialize(*args, parent: nil, assigns: [], **kwargs, &block)
        @_parent = parent

        super(*args, **kwargs)

        copy_assigns

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

    def assigns
      instance_variables
        .reject { _1.start_with? "@_" }
        .map { [_1, instance_variable_get(_1)] }.to_h
    end

    def copy_assigns
      return unless @_parent

      @_parent.assigns.each do |k, v|
        instance_variable_get(k) || instance_variable_set(k, v)
      end
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
