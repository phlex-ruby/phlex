module Phlex
  class Tag
    class VoidElement < Tag
      ELEMENTS = %w[
        area
        embed
        img
        input
        link
        meta
        param
        track
        col
      ]

      def call
        "<#{opening_tag_content} />"
      end
    end
  end
end
