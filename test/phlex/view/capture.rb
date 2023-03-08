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

	if RUBY_ENGINE == "ruby"
		with "a c-level proc" do
			view do
				def template
					capture(&:div)
				end
			end

			it "raises an argument error" do
				expect { example.call }.to raise_exception Phlex::ArgumentError
			end
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
end
