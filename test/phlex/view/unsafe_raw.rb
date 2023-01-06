# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "raw content" do
		view do
			def template
				unsafe_raw %(<h1 class="test">Hello</h1>)
			end
		end

		it "renders the correct output" do
			expect(output).to be == %(<h1 class="test">Hello</h1>)
		end
	end

	with "nil content" do
		view do
			def template
				unsafe_raw nil
			end
		end

		it "renders empty output" do
			expect(output).to be == ""
		end
	end
end
