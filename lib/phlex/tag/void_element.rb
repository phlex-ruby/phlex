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
      ].freeze

      def call
        "<#{opening_tag_content} />"
      end
    end
  end
end
