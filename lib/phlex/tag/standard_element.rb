module Phlex
  class Tag
    class StandardElement < Tag
      include Node

      def call
        "<#{opening_tag_content}>#{super}</#{self.class.tag_name}>"
      end

      def method_missing(*args, **kwargs, &block)
        super.tap { Context.new(self).call(&block) if block_given? }
      end
    end
  end
end
