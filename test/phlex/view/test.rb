# frozen_string_literal: true

require "test_helper"
require "phlex/view/test"

class Example < Phlex::View
	def template
		h1 { "👋" }
	end
end

describe Phlex::View::Test do
	include Phlex::View::Test

	describe "#render" do
		it "returns the output" do
			output = render Example.new
			expect(output).to be == "<h1>👋</h1>"
		end
	end
end
