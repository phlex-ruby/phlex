# frozen_string_literal: true

module Phlex
  class Context
    include Callable

    def initialize(container, content = nil)
      @container = container
      @content = content
    end

    def call(&block)
      instance_exec(@content, &block)
    end

    def text(content)
      self << Text.new(content)
    end

    def component(component, &block)
      self << component.new(&block)
    end

    def <<(node)
      @container.children << node
    end

    Tag.descendants.reject(&:abstract).each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag.value}(*args, **kwargs, &block)
          #{tag.name}.new(*args, **kwargs, &block).tap { self << _1 }
        end
      RUBY
    end
  end
end
