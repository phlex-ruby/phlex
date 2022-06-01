module Phlex
  class Context
    include HTML

    def initialize(content = nil, &block)
      @content = content
      @children = []
      @block = block
    end

    def build
      instance_exec(@content, &@block)
      @children.map(&:build).join
    end
  end
end
