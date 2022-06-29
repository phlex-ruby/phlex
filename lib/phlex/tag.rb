# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = " "
    NAMESPACE_DELINEATOR = "::"
    UNDERSCORE = "_"
    DASH = "-"

    class << self
      def tag_name
        @tag_name ||= name.split(NAMESPACE_DELINEATOR).last.downcase
      end
    end

    def initialize(**attributes)
      @classes ||= []
      self.attributes = attributes
    end

    def attributes=(attributes)
      self.classes = attributes.delete(:class)
      @attributes = attributes
    end

    private

    def opening_tag_content
      ([self.class.tag_name] + attributes).join(SPACE)
    end

    def attributes
      attributes = @attributes.dup
      attributes.merge!({ class: classes })
      attributes.compact!
      attributes.transform_values!(&Phlex.method(:html_escape))
      attributes.map { |k, v| %Q(#{k}="#{v}") }
    end

    def classes=(new_classes)
      case new_classes
      when Symbol
        @classes << new_classes.to_s.gsub!(UNDERSCORE, DASH)
      when String
        @classes += new_classes.gsub(UNDERSCORE, DASH).split(/\s+/)
      when Array
        @classes += new_classes.map { _1.to_s.gsub(UNDERSCORE, DASH) }
      end
    end

    def classes
      @classes.join(SPACE) if @classes.any?
    end
  end
end
