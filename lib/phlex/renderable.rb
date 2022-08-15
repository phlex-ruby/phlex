# frozen_string_literal: true
module Phlex
  module Renderable
    def render(renderable, ...)
      if renderable.is_a?(Component)
        raise ArgumentError, "Please use #component instead of #render."
      end

      @_target << @_view_context.render(renderable, ...)
    end

    def render_in(context, &)
      @_view_context = context

      if block_given?
        content = nil
        @_view_context.with_output_buffer { content = yield }
      end

      if content
        call { @_target << content }.html_safe
      else
        call.html_safe
      end
    end

    def format
      :html
    end
  end
end
