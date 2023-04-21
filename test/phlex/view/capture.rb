# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "a return value" do
		view do
			attr_accessor :captured

			def template
				h1 { "Before" }
				@captured = capture { "Hello" }
				h1 { "After" }
			end
		end

		it "captures the return value" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "Hello"
		end
	end

	with "a block" do
		view do
			attr_accessor :captured

			def template
				h1 { "Before" }
				@captured = capture do
					h1 { "Hello" }
				end
				h1 { "After" }
			end
		end

		it "captures the return value" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "<h1>Hello</h1>"
		end
	end

	with "a call to flush inside the block" do
		view do
			attr_accessor :captured

			def template
				h1 { "Before" }
				@captured = capture do
					h1 { "Hello" }
					flush
					h1 { "World" }
				end
				h1 { "After" }
			end
		end

		it "should still contain the full capture" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "<h1>Hello</h1><h1>World</h1>"
		end
	end
end
