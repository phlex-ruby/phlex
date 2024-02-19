# frozen_string_literal: true

module Phlex::Testing
	module ViewHelper
		def render(view, &block)
			if view.is_a?(Class) && view < Phlex::SGML
				view = view.new
			end

			view.call(&block)
		end
	end
end
