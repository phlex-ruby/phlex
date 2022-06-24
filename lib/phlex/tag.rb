# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = " "
    NAMESPACE_DELINEATOR = "::"
    HTML_ESCAPE = ERB::Util.method(:html_escape)

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

    def call
      raise NoMethodError
    end

    def attributes=(attributes)
      attributes.transform_keys!(&:to_sym)
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
        .transform_values(&HTML_ESCAPE)
        .transform_keys(&HTML_ESCAPE)
        .map { |k, v| %Q(#{k}="#{v}") }
    end

    def classes=(classes)
      @classes += classes
        .then { _1.is_a?(String) ? _1.split(SPACE) : Array(_1) }
        .map { _1.to_s.dasherize }
    end

    def classes
      @classes.join(SPACE) if @classes.any?
    end
  end
end
