# frozen_string_literal: true

require "phlex/view/test/capybara"

class Example < Phlex::View
	def template
		h1 { "👋" }
	end
end

describe Phlex::View::Test::Capybara do
	include Phlex::View::Test::Capybara

	describe "#render" do
		it "sets the page" do
			render Example.new

			expect(page.all("h1").first.text).to be == "👋"
		end
	end
end
