# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
  using Overrides::Symbol::Name
end

module Phlex
  module Context
    extend Tag

    def content(&block)
      original_bytesize = @_target.size
      output = yield if block_given?
      unchanged = (original_bytesize == @_target.size)

      text(output) if unchanged && output.is_a?(String)
    end

    def text(content)
      @_target << CGI.escape_html(content)
    end

    def whitespace
      @_target << " "
    end

    def doctype
      @_target << Tag::DOCTYPE
    end

    def _raw(content)
      @_target << content
    end

    Tag::STANDARD_ELEMENTS.each do |tag_name|
      register_element(tag_name)
    end

    Tag::VOID_ELEMENTS.each do |tag_name|
      register_void_element(tag_name)
    end

    register_element :template_tag, tag: "template"

    def _attributes(attributes)
      if (cached = Phlex::ATTRIBUTE_CACHE[attributes.hash])
        return @_target << cached
      end

      first_render = !self.class.rendered_at_least_once

      buffer = first_render ? buffer = +"" : buffer = @_target

      attributes[:href] = attributes[:href].sub(/^\s*(javascript:)+/, "") if attributes[:href]

      attributes.each do |k, v|
        next unless v

        if Tag::EVENT_ATTRIBUTES[k] || k.match?(/[<>&"']/)
          raise ArgumentError, "Unsafe attribute name detected: #{k}."
        end

        if v == true
          buffer << Tag::SPACE << k.name.gsub(Tag::UNDERSCORE, Tag::DASH)
        else
          buffer << Tag::SPACE << k.name.gsub(Tag::UNDERSCORE, Tag::DASH) << Tag::EQUALS_QUOTE << CGI.escape_html(v.to_s) << Tag::QUOTE
        end
      end

      if first_render
        @_target << Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
      end
    end
  end
end
