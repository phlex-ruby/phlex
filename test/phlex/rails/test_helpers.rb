# frozen_string_literal: true

require "test_helper"
require "phlex/rails/test_helpers"

describe Phlex::Rails::TestHelpers do
	include Phlex::Rails::TestHelpers

	describe "#view_context" do
		it "is the controller's view context" do
			expect(view_context.controller).to be == controller
		end
	end

	describe "#controller" do
		it "is an ActionView::TestCase::TestController" do
			expect(controller).to be_a ActionView::TestCase::TestController
		end

		it "is memoized" do
			a, b = controller, controller
			expect(a).to be == b
		end
	end
end
