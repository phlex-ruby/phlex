# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
  using Overrides::Symbol::Name
end

module Phlex
  class Component
    extend HTML
    include Renderable

    class << self
      attr_accessor :rendered_at_least_once

      def new(*args, **kwargs, &block)
        component = super(*args, **kwargs)

        component.instance_exec do
          @_content = block
          @_rendered = false
        end

        component
      end
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def call(buffer = +"", view_context: nil, parent: nil, &block)
      raise "The same component instance shouldn't be rendered twice" if @_rendered

      @_rendered = true
      @_target = buffer
      @_view_context = view_context
      @_parent = parent

      block_given? ? template(&block) : template(&@_content)

      self.class.rendered_at_least_once ||= true

      buffer
    end

    HTML::STANDARD_ELEMENTS.each do |element|
      register_element(element)
    end

    HTML::VOID_ELEMENTS.each do |element|
      register_void_element(element)
    end

    register_element :template_tag, tag: "template"

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
      @_target << HTML::DOCTYPE
    end

    def _raw(content)
      @_target << content
    end

    def _attributes(attributes)
      if (cached = Phlex::ATTRIBUTE_CACHE[attributes.hash])
        return @_target << cached
      end

      first_render = !self.class.rendered_at_least_once

      buffer = first_render ? buffer = +"" : buffer = @_target

      if attributes[:href]&.start_with?(/\s*javascript/)
        attributes[:href] = attributes[:href].sub(/^\s*(javascript:)+/, "")
      end

      attributes.each do |k, v|
        next unless v

        if HTML::EVENT_ATTRIBUTES[k] || k.match?(/[<>&"']/)
          raise ArgumentError, "Unsafe attribute name detected: #{k}."
        end

        if v == true
          buffer << " " << k.name.tr("_", "-")
        else
          buffer << " " << k.name.tr("_", "-") << '="' << CGI.escape_html(v.to_s) << '"'
        end
      end

      if first_render
        @_target << Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
      end
    end
  end
end
