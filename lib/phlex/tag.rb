# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = ' '
    include Phlex::HTML

    def initialize(parent, name, content = nil, **attributes, &block)
      raise ArgumentError if content && block_given?

      @parent = parent
      @name = name
      @content = content
      @attributes = attributes
      @children = []

      instance_eval(&block) if block_given?
    end

    def build
      "#{opening_tag}#{content}#{closing_tag}"
    end

    private

    def opening_tag
      "<#{opening_tag_content.join(SPACE)}>"
    end

    def opening_tag_content
      [@name] + @attributes.map { |k, v| "#{k} = '#{v}'" }
    end

    def content
      @content || @children.map(&:build).join
    end

    def closing_tag
      "</#{@name}>"
    end
  end
end
