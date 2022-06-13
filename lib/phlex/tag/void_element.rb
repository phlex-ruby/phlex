module Phlex
  class Tag
    class VoidElement < Tag
      def call
        "<#{opening_tag_content} />"
      end
    end
  end
end
