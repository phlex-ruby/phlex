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

      if args.one? && !block_given?
        self << component.new(**kwargs) { text(args.first) }
      else
        self << component.new(*args, **kwargs, &block)
      end
    end

    def _template_tag(*args, **kwargs, &)
      _standard_element(*args, _name: "template", **kwargs, &)
    end

    def _standard_element(content = nil, _name: nil, **kwargs, &block)
      raise ArgumentError if content && block_given?

      name = _name ||= __callee__.name
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

    def _void_element(**kwargs)
      tag = Tag::VoidElement.new(__callee__.name, **kwargs)
      self << tag
      Tag::ClassCollector.new(self, tag)
    end

    Tag::StandardElement::ELEMENTS.each do |tag_name|
      alias_method tag_name, :_standard_element
    end

    Tag::VoidElement::ELEMENTS.each do |tag_name|
      alias_method tag_name, :_void_element
    end
  end
end
