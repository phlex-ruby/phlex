# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = " "
    NAMESPACE_DELINEATOR = "::"
    HTML_ESCAPE = ERB::Util.method(:html_escape)

    class << self
      attr_accessor :abstract

      def value
        name.split(NAMESPACE_DELINEATOR).last.downcase
      end
    end

    def call
      raise NoMethodError
    end

    def initialize(**attributes)
      @attributes = attributes
        .transform_keys(&:to_sym)
        .transform_values { _1.split(SPACE) if _1.is_a?(String) }
    end

    # def method_missing(name, *args, **kwargs, &block)
    #   @attributes[:class] ||= []
    #   @attributes[:class] << name
    #   self
    # end

    private

    def meta_data
      ([self.class.value] + build_attributes).join(SPACE)
    end

    def build_attributes
      @attributes
        .transform_values { _1.join(SPACE) }
        .transform_values(&HTML_ESCAPE)
        .transform_keys(&HTML_ESCAPE)
        .map { |k, v| "#{k}=\"#{v}\"" }
    end
  end
end
