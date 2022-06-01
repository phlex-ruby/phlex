module Phlex
  class Tag
    class StandardElement < Tag
      include Node

      self.abstract = true

      def initialize(content = nil, **attributes, &block)
        raise ArgumentError if content && block_given?

        super(**attributes)

        if block_given?
          Context.new(self).call(&block)
        elsif content
          Context.new(self).call { text content }
        end
      end

      def call
        "<#{meta_data}>#{super}</#{self.class.value}>"
      end

      def method_missing(*args, **kwargs, &block)
        super.tap { Context.new(self).call(&block) if block_given? }
      end
    end
  end
end
