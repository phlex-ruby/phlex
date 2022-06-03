module Phlex
  module Node
    include Callable

    def children
      @_children ||= []
    end

    def call
      children.map(&:call).join
    end
  end
end
