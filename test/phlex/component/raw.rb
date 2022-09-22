# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	extend ComponentHelper

	with "raw content" do
		component do
			def template
				raw %(<h1 class="test">Hello</h1>)
			end
		end

		it "renders produces the correct output" do
			expect(output).to be == %(<h1 class="test">Hello</h1>)
		end
	end
end
