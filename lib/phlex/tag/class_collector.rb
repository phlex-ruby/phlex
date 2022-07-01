module Phlex
  class Tag
    class ClassCollector
      def initialize(context, tag)
        @context = context
        @tag = tag
      end

      def method_missing(name, content = nil, *args, **attributes, &block)
        @tag.classes = name
        @tag.attributes = attributes if attributes

        if block_given?
          if block.binding.receiver.is_a?(Block)
            block.call(@tag)
          else
            Block.new(@context, &block).call(@tag)
          end
        end

        Block.new(@context) { text content }.call(@tag) if content

        self
      end
    end
  end
end
