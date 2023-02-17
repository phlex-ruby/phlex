# frozen_string_literal: true

require "phlex/testing/view_helper"

class ExampleHTML < Phlex::HTML
	def template
		h1 { "👋" }
	end
end

class ExampleSVG < Phlex::SVG
	def template
		svg do
			path(d: "123")
		end
	end
end

describe Phlex::Testing::ViewHelper do
	include Phlex::Testing::ViewHelper

	describe "#render" do
		it "returns the output" do
			output = render ExampleHTML
			expect(output).to be == "<h1>👋</h1>"
		end
	end

	describe "#render with SVG" do
		it "returns the output" do
			output = render ExampleSVG
			expect(output).to be == "<svg><path d=\"123\"></path></svg>"
		end
	end
end
