# frozen_string_literal: true

module Phlex
  module Context
    def text(content)
      self << Text.new(content)
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

    Tag::StandardElement.subclasses.each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag.tag_name}(content = nil, **kwargs, &block)
          raise ArgumentError if content && block_given?
          tag = #{tag.name}.new(**kwargs)
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
      RUBY
    end

    Tag::VoidElement.subclasses.each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag.tag_name}(**kwargs)
          tag = #{tag.name}.new(**kwargs)
          self << tag
          Tag::ClassCollector.new(self, tag)
        end
      RUBY
    end
  end
end
