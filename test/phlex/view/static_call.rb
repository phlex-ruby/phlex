# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		h1 { "Hi" }
	end
end

describe Phlex::HTML do
	with "static #call" do
		it "renders the view" do
			expect(Example.call).to be == "<h1>Hi</h1>"
		end
	end
end
