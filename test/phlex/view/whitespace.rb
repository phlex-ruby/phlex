# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "whitespace" do
		view do
			def view_template
				a { "Home" }
				whitespace
				a { "About" }
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<a>Home</a> <a>About</a>"
		end
	end

	with "whitespace around" do
		view do
			def view_template
				whitespace do
					a { "Home" }
				end
			end
		end

		it "produces the correct output" do
			expect(output).to be == " <a>Home</a> "
		end
	end

	with "whitespace around a string" do
		view do
			def view_template
				span { "9" }
				whitespace { "out of" }
				span { "10" }
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<span>9</span> out of <span>10</span>"
		end
	end
end
