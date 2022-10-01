# frozen_string_literal: true

require "isolated_test_helper"

describe Phlex::View do
	extend ViewHelper

	with "raw content" do
		view do
			def template
				raw %(<h1 class="test">Hello</h1>)
			end
		end

		it "renders produces the correct output" do
			expect(output).to be == %(<h1 class="test">Hello</h1>)
		end
	end
end
