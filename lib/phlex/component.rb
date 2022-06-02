# frozen_string_literal: true

module Phlex
  class Component
    include Node, Context

    module Initializer
      def initialize(*args, **kwargs, &block)
        super(*args, **kwargs)
        template(&block)
      end
    end

    def self.inherited(child)
      child.prepend(Initializer)
    end

    def render_context
      @render_context ||= self
    end

    def <<(node)
      render_context.children << node
    end

    def render(&block)
      instance_eval(&block) if block_given?
    end

    def render_tag(tag, &block)
      old_render_context = render_context.dup
      @render_context = tag
      instance_eval(&block)
      @render_context = old_render_context
    end

    # def h1(content = nil, &block)
    #   self << H1.new(content, component: self, &block)
    # end
  end
end
