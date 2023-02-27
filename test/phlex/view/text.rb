# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "text" do
		view do
			def template
				plain "Hi"
			end
		end

		it "produces the correct output" do
			expect(output).to be == "Hi"
		end
	end

	with "int as text" do
		view do
			def template
				plain 1
			end
		end

		it "produces the correct output" do
			expect(output).to be == "1"
		end
	end

	with "float as text" do
		view do
			def template
				plain 2.0
			end
		end

		it "produces the correct output" do
			expect(output).to be == "2.0"
		end
	end
end
