# frozen_string_literal: true

module Phlex
	module TestHelpers
		def render(view, &block)
			@output = view.call(view_context: view_context, &block)
		end

		def view_context
			nil
		end
	end
end
