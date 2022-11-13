# frozen_string_literal: true

require "phlex/testing/view_helper"

class Example < Phlex::HTML
	def template
		h1 { "👋" }
	end
end

describe Phlex::Testing::ViewHelper do
	include Phlex::Testing::ViewHelper

	describe "#render" do
		it "returns the output" do
			output = render Example.new
			expect(output).to be == "<h1>👋</h1>"
		end
	end
end
