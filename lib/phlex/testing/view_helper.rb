# frozen_string_literal: true

module Phlex::Testing
	module ViewHelper
		def render(view, &block)
			if view.is_a?(Class) && view < Phlex::SGML
				view = view.new
			end

			view.call(view_context:, &block)
		end

		def view_context
			nil
		end
	end
end
