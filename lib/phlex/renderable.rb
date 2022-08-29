# frozen_string_literal: true

module Phlex
  module Renderable
    def render(renderable, *args, **kwargs, &block)
      if renderable.is_a?(Component)
        if block_given? && !block.binding.receiver.is_a?(Phlex::Block)
          block = Phlex::Block.new(self, &block)
        end

        renderable.call(@_target, view_context: @_view_context, parent: self, &block)
      else
        @_target << @_view_context.render(renderable, *args, **kwargs, &block)
      end
    end

    def render_in(view_context, &block)
      if block_given?
        content = nil
        view_context.with_output_buffer { content = yield }
      end

      if content
        call(view_context: view_context) { @_target << content }.html_safe
      else
        call(view_context: view_context).html_safe
      end
    end

    def format
      :html
    end
  end
end
