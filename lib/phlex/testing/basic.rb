# frozen_string_literal: true

module Phlex
	module Testing
		module Basic
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

		# Create an alias for the Basic module
		ViewHelper = Basic
	end
end
