# frozen_string_literal: true

module Phlex
  class Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    class << self
      def tag_name
        @tag_name ||= name.split(NAMESPACE_DELINEATOR).last.downcase
      end
    end

    def initialize(**attributes)
      @classes = String.new
      self.attributes = attributes
    end

    def attributes=(attributes)
      self.classes = attributes.delete(:class)
      @attributes = attributes
    end

    def classes=(value)
      case value
      when String
        @classes << value.prepend(SPACE)
      when Symbol
        @classes << value.to_s.prepend(SPACE)
      when Array
        @classes << value.join(SPACE).prepend(SPACE)
      when nil
        return
      else
        raise ArgumentError, "Classes must be String, Symbol, or Array<String>."
      end
    end

    private

    def opening_tag_content
      self.class.tag_name + attributes
    end

    def attributes
      attributes = @attributes.dup
      attributes.merge!({ class: classes })
      attributes.compact!
      attributes.transform_values! { ERB::Util.html_escape(_1) }
      attributes = attributes.map { |k, v| %Q(#{k}="#{v}") }.join(SPACE)
      attributes.prepend(SPACE) unless attributes.empty?
      attributes
    end

    def classes
      return if @classes.empty?
      @classes.gsub!(UNDERSCORE, DASH)
      @classes.strip!
      @classes
    end
  end
end
