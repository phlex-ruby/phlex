# frozen_string_literal: true

require "phlex/testing/capybara/view_helper"

class Example < Phlex::HTML
	def template
		h1 { "👋" }
	end
end

describe Phlex::Testing::Capybara::ViewHelper do
	include Phlex::Testing::Capybara::ViewHelper

	describe "#render" do
		it "sets the page" do
			render Example.new

			expect(page.all("h1").first.text).to be == "👋"
		end
	end
end
