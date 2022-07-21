# frozen_string_literal: true

module Phlex
  module Context
    def text(content)
      self << Text.new(content)
    end

    def whitespace
      _raw(" ")
    end

    def _raw(content)
      self << Raw.new(content)
    end

    def component(component, *args, **kwargs, &block)
      unless component < Component
        raise ArgumentError, "#{component.name} isn't a Phlex::Component."
      end

      if block_given? && !block.binding.receiver.is_a?(Block)
        block = Block.new(self, &block)
      end

      self << component.new(*args, **kwargs, &block)
    end

    def _template_tag(...)
      _standard_element("template", ...)
    end

    def _standard_element(name, content = nil, **kwargs, &block)
      raise ArgumentError if content && block_given?
      tag = Tag::StandardElement.new(name, **kwargs)
      self << tag

      if block_given?
        if block.binding.receiver.is_a?(Block)
          block.call(tag)
        else
          Block.new(self, &block).call(tag)
        end
      end

      Block.new(self) { text content }.call(tag) if content

      Tag::ClassCollector.new(self, tag)
    end

    def _void_element(name, **kwargs)
      tag = Tag::VoidElement.new(name, **kwargs)
      self << tag
      Tag::ClassCollector.new(self, tag)
    end

    Tag::StandardElement::ELEMENTS.each do |tag_name|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag_name}(...)
          _standard_element("#{tag_name}", ...)
        end
      RUBY
    end

    Tag::VoidElement::ELEMENTS.each do |tag_name|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag_name}(...)
          _void_element("#{tag_name}", ...)
        end
      RUBY
    end
  end
end
