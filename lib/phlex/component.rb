# frozen_string_literal: true

module Phlex
  class Component
    include Context

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

    class << self
      attr_accessor :rendered_at_least_once

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
        if child.name
          namespace = child.name.split("::")[0..-2]
          if namespace.any?
            ns = namespace.join("::").constantize

            ns.define_singleton_method(child.name.demodulize) do |*args, **kwargs, &block|
              if block_given? && !block.binding.receiver.is_a?(Block)
                block = Block.new(self, &block)
              end

              child.new(*args, **kwargs, &block).call
            end

            ns.define_method(child.name.demodulize) do |*args, **kwargs, &block|
              if block_given? && !block.binding.receiver.is_a?(Block)
                block = Block.new(self, &block)
              end

              child.new(*args, **kwargs, &block).call(@_target)
            end
          else
            define_method(child.name.demodulize) do |*args, **kwargs, &block|
              if block_given? && !block.binding.receiver.is_a?(Block)
                block = Block.new(self, &block)
              end

              child.new(*args, **kwargs, &block).call(@_target)
            end
          end
        end

        child.prepend(Overrides)
        super
      end
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def call(buffer = Thread.current[:phlex_buffer] ||= +"")
      raise "The same component instance shouldn't be rendered twice" if @_rendered
      @_rendered = true

      @_target = buffer
      template(&@_content)
      self.class.rendered_at_least_once ||= true
      Thread.current[:phlex_buffer] = nil
      buffer
    end
  end
end
