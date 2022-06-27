# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = " "
    NAMESPACE_DELINEATOR = "::"

    class << self
      attr_accessor :abstract

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
      @attributes
        .merge({ class: classes })
        .compact
        .transform_values(&Phlex.method(:html_escape))
        .map { |k, v| %Q(#{k}="#{v}") }
    end

    def classes=(new_classes)
      @classes += new_classes
        .then { _1.is_a?(String) ? _1.split(SPACE) : Array(_1) }
        .map { _1.to_s.dasherize }
    end

    def classes
      @classes.join(SPACE) if @classes.any?
    end
  end
end
