# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	with "whitespace" do
		view do
			def template
				a { "Home" }
				whitespace
				a { "About" }
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<a>Home</a> <a>About</a>"
		end
	end
end
