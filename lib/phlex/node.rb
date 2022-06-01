module Phlex
  module Node
    include Callable

    def children
      return @children if defined? @children
      @children = []
    end

    def call
      children.map(&:call).join
    end
  end
end
