# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "content" do
		view do
			def template
				h1 { "Before" }
				yield
				h2 { "After" }
			end
		end

		it "renders text content" do
			expect(example.call { "Hi" }).to be == "<h1>Before</h1>Hi<h2>After</h2>"
		end
	end
end
