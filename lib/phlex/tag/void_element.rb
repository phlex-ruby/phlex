# frozen_string_literal: true

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

      def call(buffer = +"")
        buffer << LEFT << name
        attributes(buffer)
        buffer << CLOSE_VOID_RIGHT
      end
    end
  end
end
