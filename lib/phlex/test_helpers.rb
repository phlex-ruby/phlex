# frozen_string_literal: true

module Phlex
	module TestHelpers
		def render(view, &block)
			@output = view.render_in(view_context, &block)
		end

		def view_context
			nil
		end
	end
end
