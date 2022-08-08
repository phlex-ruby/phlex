# frozen_string_literal: true

require "digest"

module Phlex
  class Component
    module Overrides
      def initialize(*args, **kwargs, &block)
        if block_given? && !block.binding.receiver.is_a?(Block)
          block = Block.new(self, &block)
        end

        @_content = block

        super(*args, **kwargs)
      end

      def template(...)
        called_from = caller_locations(1,1)[0].label.to_sym

        # If we're rendering a template and not being called from
        # another override in the ancestry, we render the template tag.

        if @_rendering && (called_from != __method__)
          _template_tag(...)
        else
          @_rendering = true
          super
          @_rendering = false
        end
      end
    end

    include ParentNode, Context

    class << self
      def register_element(*tag_names)
        tag_names.each do |tag_name|
          unless tag_name.is_a? Symbol
            raise ArgumentError, "Custom elements must be provided as Symbols"
          end

          class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
            def #{tag_name}(*args, **kwargs, &)
              _standard_element(*args, _name: "#{tag_name.to_s.gsub('_', '-')}", **kwargs, &)
            end
          RUBY
        end
      end

      def inherited(child)
        child.prepend(Overrides)
        super
      end
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def call(buffer = +"")
      raise "The same component instance shouldn't be rendered twice" if @_rendered
      @_rendered = true

      template(&@_content)
      super
    end

    def target
      @_target || self
    end

    def content
      yield(target) if block_given?
    end

    def render_block(new_target, ...)
      old_target = target
      @_target = new_target
      @_rendering_block = true
      instance_exec(...)
      @_rendering_block = false
      @_target = old_target
    end
  end
end
