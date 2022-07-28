# frozen_string_literal: true

module Phlex
  class Tag
    class ClassCollector < BasicObject
      def initialize(context, tag)
        @context = context
        @tag = tag
      end

      define_method :__class__, ::Kernel.instance_method(:class)
      define_method :__callee__, ::Kernel.instance_method(:__callee__)

      def __add_class__(content = nil, **attributes, &block)
        @tag.classes = __callee__.name
        @tag.attributes = attributes if attributes

        if ::Kernel.block_given?
          if block.binding.receiver.is_a?(Block)
            block.call(@tag)
          else
            ::Phlex::Block.new(@context, &block).call(@tag)
          end
        end

        ::Phlex::Block.new(@context) { text content }.call(@tag) if content

        self
      end

      def method_missing(name, content = nil, **attributes, &block)
        __class__.alias_method(name, :__add_class__)
        __send__(name, content, **attributes, &block)
      end
    end
  end
end
