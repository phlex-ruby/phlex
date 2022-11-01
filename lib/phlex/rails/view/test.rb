# frozen_string_literal: true

require "phlex/view/test"

module Phlex::Rails::View::Test
	include Phlex::View::Test

	def view_context
		controller.view_context
	end

	def controller
		@controller ||= ActionView::TestCase::TestController.new
	end
end
