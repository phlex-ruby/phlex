# frozen_string_literal: true

describe Phlex::View do
	extend ViewHelper

	with "callbacks" do
		view do
			prepend Phlex::View::Callbacks

			def before_rendering_template
				h1 { "Hello" }
			end

			def template
				h2 { "World" }
			end

			def after_rendering_template
				h3 { "Bye" }
			end
		end

		it "calls before and after template" do
			expect(output).to be == "<h1>Hello</h1><h2>World</h2><h3>Bye</h3>"
		end
	end
end
