# frozen_string_literal: true

describe Phlex::HTML do
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

	with "whitespace around" do
		view do
			def template
				whitespace do
					a { "Home" }
				end
			end
		end

		it "produces the correct output" do
			expect(output).to be == " <a>Home</a> "
		end
	end
end
