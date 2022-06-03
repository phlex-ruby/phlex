# frozen_string_literal: true

module Phlex
  module Context
    def text(content)
      self << Text.new(content)
    end

    def component(component, *args, **kwargs, &block)
      assigns = instance_variables
        .reject { _1.start_with? "@_" }
        .map { [_1, instance_variable_get(_1)] }.to_h

      comp = component.new(*args, parent: self, assigns:, **kwargs, &block)
      self << comp
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
