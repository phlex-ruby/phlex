# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "around_template hook" do
		view do
			def around_template
				h1 { "Before" }
				super
				h3 { "After" }
			end

			def view_template
				h2 { "Hello" }
			end
		end

		it "wraps the template" do
			expect(output).to be == "<h1>Before</h1><h2>Hello</h2><h3>After</h3>"
		end
	end
end
