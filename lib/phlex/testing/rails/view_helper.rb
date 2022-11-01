# frozen_string_literal: true

require "phlex/testing/view_helper"

module Phlex::Testing
	module Rails
		module ViewHelper
			include Phlex::Testing::ViewHelper

			def view_context
				controller.view_context
			end

			def controller
				@controller ||= ActionView::TestCase::TestController.new
			end
		end
	end
end
