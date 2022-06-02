module Phlex
  class Tag
    class StandardElement < Tag
      include Node

      def call
        "<#{meta_data}>#{super}</#{self.class.value}>"
      end

      def method_missing(*args, **kwargs, &block)
        super.tap { Context.new(self).call(&block) if block_given? }
      end
    end
  end
end
