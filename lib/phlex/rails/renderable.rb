# frozen_string_literal: true

module Phlex
  module Rails
    # This hack gives us a view context for an ActionController controller with a root name.
    VIEW_CONTEXT = Class.new(ActionController::Base) { def self.name = "" }.new.view_context

    module Renderable
      def render(...)
        if @_rendering || @_rendering_block
          _raw VIEW_CONTEXT.render(...)
        else
          call.html_safe
        end
      end

      def render_in(context, &)
        if block_given?
          content = nil
          context.with_output_buffer { content = yield }
          @_content = Phlex::Block.new(self) { _raw content }
        end

        render
      end

      def format
        :html
      end
    end
  end
end

Phlex::Context.include(Phlex::Rails::Renderable)
