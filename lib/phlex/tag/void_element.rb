module Phlex
  class Tag
    class VoidElement < Tag
      self.abstract = true

      def call
        "<#{meta_data} />"
      end
    end
  end
end
