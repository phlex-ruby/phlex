# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "numbers" do
		view do
			def view_template
				span { 1 }

				span { 2.0 }
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<span>1</span><span>2.0</span>"
		end
	end
end
