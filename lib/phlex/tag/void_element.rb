module Phlex
  class Tag
    class VoidElement < Tag
      def call
        "<#{meta_data} />"
      end
    end
  end
end
