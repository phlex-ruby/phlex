# frozen_string_literal: true

class Example
	include Phlex::HTML

	def template
		h1 { "Hi" }
	end
end

describe Phlex::HTML do
	with "static #call" do
		it "renders the view" do
			expect(Example.call).to be == "<h1>Hi</h1>"
		end
	end

	with "static #render" do
		it "renders the view" do
			expect(Example.render).to be == "<h1>Hi</h1>"
		end
	end
end
