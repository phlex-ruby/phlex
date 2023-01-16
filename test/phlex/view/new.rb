# frozen_string_literal: true

class Example < Phlex::HTML
	def template(&block)
		h1(&block)
	end
end

describe Phlex::HTML do
	extend ViewHelper

	with "a block passed to new" do
		view do
			def template
				render Example.new { "Hello" }
			end
		end

		it "treats the block as content" do
			expect(output).to be == "<h1>Hello</h1>"
		end
	end
end
