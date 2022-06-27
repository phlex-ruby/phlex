module Phlex
  class Block
    def initialize(context, &block)
      @context = context
      @block = block
    end

    def call(target, *args, **kwargs)
      @context.render_block(target, *args, **kwargs, &@block)
    end

    def to_proc
      method(:call).to_proc
    end
  end
end
