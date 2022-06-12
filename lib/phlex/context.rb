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

      self << component.new(*args, parent: self, **kwargs, &block)
    end

    Tag::StandardElement.subclasses.each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag.value}(content = nil, **kwargs, &block)
          raise ArgumentError if content && block_given?
          tag = #{tag.name}.new(**kwargs)
          self << tag
          render_tag(tag, &block) if block_given?
          render_tag(tag) { text content } if content
        end
      RUBY
    end

    Tag::VoidElement.subclasses.each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag.value}(**kwargs)
          tag = #{tag.name}.new(**kwargs)
          self << tag
        end
      RUBY
    end
  end
end
