# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "hooks" do
		view do
			def before_template
				h1 { "Hello" }
			end

			def view_template
				h2 { "World" }
			end

			def after_template
				h3 { "Bye" }
			end
		end

		it "calls before and after template" do
			expect(output).to be == "<h1>Hello</h1><h2>World</h2><h3>Bye</h3>"
		end
	end
end
