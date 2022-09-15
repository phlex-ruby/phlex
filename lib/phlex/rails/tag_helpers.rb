# frozen_string_literal: true

module Phlex
  module Rails
    module TagHelpers
      def form_with(*args, **kwargs, &block)
        raw @_view_context.form_with(*args, **kwargs) { |form|
          capture do
            yield(
              Phlex::Buffered.new(form, buffer: @_target)
            )
          end
        }
      end

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
