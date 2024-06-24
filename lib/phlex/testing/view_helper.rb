# frozen_string_literal: true

module Phlex::Testing
	module ViewHelper
		def render(view, &)
			if view.is_a?(Class) && view < Phlex::SGML
				view = view.new
			end

			view.call(view_context:, &)
		end

		def view_context
			nil
		end
	end
end
