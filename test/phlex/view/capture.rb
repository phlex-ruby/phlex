# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "a return value" do
		view do
			attr_accessor :captured

			def template
				@captured = capture { "Hello" }
			end
		end

		it "captures the return value" do
			example.call
			expect(example.captured).to be == "Hello"
		end
	end

	with "a block" do
		view do
			attr_accessor :captured

			def template
				@captured = capture do
					h1 { "Hello" }
				end
			end
		end

		it "captures the return value" do
			example.call
			expect(example.captured).to be == "<h1>Hello</h1>"
		end
	end
end
