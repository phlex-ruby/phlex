# frozen_string_literal: true

module Phlex
	module Testing
		module ViewHelper
			def render(view, &block)
				view.call(view_context: view_context, &block)
			end

			def view_context
				nil
			end
		end
	end
end
