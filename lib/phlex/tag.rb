# frozen_string_literal: true

module Phlex
  class Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    attr_reader :name

    def initialize(name, **attributes)
      @name = name
      @classes = +""
      self.attributes = attributes
    end

    def attributes=(attributes)
      self.classes = attributes.delete(:class)
      @attributes = attributes
    end

    def classes=(value)
      case value
      when String
        @classes << SPACE << value
      when Symbol
        @classes << SPACE << value.to_s
      when Array
        value.each { @classes << SPACE << _1 }
      when nil
        return
      else
        raise ArgumentError, "Classes must be String, Symbol, or Array<String>."
      end
    end

    private

    def attributes(buffer = +"")
      attributes = @attributes.dup
      attributes[:class] = classes
      attributes.compact!
      attributes.transform_values! { CGI.escape_html(_1) }
      attributes[:href].sub!(/^\s*(javascript:)+/, "") if attributes[:href]
      attributes.each { |k, v| buffer << SPACE << k.name << '="' << v << '"' }
      buffer
    end

    def classes
      return if @classes.empty?
      @classes.strip!
      @classes
    end
  end
end
