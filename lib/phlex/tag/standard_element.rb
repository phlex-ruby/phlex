module Phlex
  class Tag
    class StandardElement < Tag
      include Node

      def call
        "<#{opening_tag_content}>#{super}</#{self.class.tag_name}>"
      end
    end
  end
end
