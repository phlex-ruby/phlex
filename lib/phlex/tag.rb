# frozen_string_literal: true

module Phlex
  class Tag
    SPACE = " "
    NAMESPACE_DELINEATOR = "::"

    class << self
      attr_accessor :abstract

      def value
        name.split(NAMESPACE_DELINEATOR).last.downcase
      end

      def descendants
        Enumerator.new do |yielder|
          subclasses.each do |subclass|
            yielder << subclass
            subclass.descendants.each { yielder << _1 }
          end
        end
      end
    end

    self.abstract = true

    def call
      raise NoMethodError
    end

    def initialize(**attributes)
      @attributes = attributes
    end

    def method_missing(name, *args, **kwargs, &block)
      @attributes[:class] ||= []
      @attributes[:class] << name
      self
    end

    private

    def meta_data
      ([self.class.value] + build_attributes).join(SPACE)
    end

    def build_attributes
      @attributes
        .transform_values { _1.join(SPACE) }
        .map { |k, v| "#{k}=\"#{v}\"" }
    end
  end
end
