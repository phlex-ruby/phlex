# frozen_string_literal: true

module Phlex
  class Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    LEFT = "<"
    RIGHT = ">"
    CLOSE_LEFT = "</"
    CLOSE_VOID_RIGHT = " />"

    attr_reader :name

    def initialize(name, **attributes)
      @name = name
      @attributes = attributes
    end

    private

    def attributes(buffer = +"")
      @attributes.transform_values! { CGI.escape_html(_1) }
      @attributes[:href].sub!(/^\s*(javascript:)+/, "") if @attributes[:href]
      @attributes.each { |k, v| buffer << SPACE << k.name << '="' << v << '"' }
      buffer
    end
  end
end
