# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	view do
		def template
			text "Hi"
		end
	end

	with "#call" do
		it "renders the view" do
			expect(example.call).to be == "Hi"
		end
	end

	with "`render?` method returning false" do
		view do
			def template
				text "Hi"
			end

			def render?
				false
			end
		end

		it "returns buffer content" do
			buffer = "xyz"
			expect(example.call(buffer)).to be == "xyz"
		end
	end
end
