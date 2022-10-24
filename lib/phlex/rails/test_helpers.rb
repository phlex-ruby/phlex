# frozen_string_literal: true

require "phlex/test_helpers"

module Phlex
	module Rails
		module TestHelpers
			include Phlex::TestHelpers

			def view_context
				controller.view_context
			end

			def controller
				@controller ||= ActionView::TestCase::TestController.new
			end
		end
	end
end
