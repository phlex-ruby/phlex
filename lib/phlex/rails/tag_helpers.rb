# frozen_string_literal: true

module Phlex
  module Rails
    module TagHelpers
      def csp_meta_tag
        if (output = @_view_context.csp_meta_tag)
          @_target << output
        end
      end

      def csrf_meta_tags
        if (output = @_view_context.csrf_meta_tags)
          @_target << output
        end
      end
    end
  end
end
