# frozen_string_literal: true

require "test_helper"
require "phlex/capybara/test_helpers"

class Example < Phlex::View
	def template
		h1 { "Hello" }
	end
end

describe Phlex::Capybara::TestHelpers do
	include Phlex::Capybara::TestHelpers

	describe "#page" do
		it "returns the rendered view as capybara node" do
			render Example.new

			expect(page).to be_a Capybara::Node::Simple
			expect(page.all("h1").first.text).to be == "Hello"
		end

		it "memoizes the results" do
			a, b = page, page
			expect(a).to be == b
		end
	end
end
