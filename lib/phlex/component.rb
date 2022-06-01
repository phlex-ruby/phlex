# frozen_string_literal: true

module Phlex
  class Component
    def initialize(*args, **kwargs, &block)
      @args = args
      @kwargs = kwargs
      @block = block
    end

    def build
      instance_exec(@content, **@kwargs, &self.class.template)
      @children.join
    end

    def render(&block)
      Phlex::Context.new
    end
  end
end
