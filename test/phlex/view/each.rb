# frozen_string_literal: true

class Example < Phlex::HTML
	def template
		h1 { "Hello, world!" }
	end
end

describe "#each" do
	it "returns an enumerator" do
		expect(Example.new.each).to be_a Enumerator
		expect(Example.new.each.to_a).to be == ([%(<h1>Hello, world!</h1>)])
	end

	with "block" do
		it "yields each fragment to the block" do
			fragments = []

			Example.new.each do |fragment|
				fragments << fragment
			end

			expect(fragments).to be == ([%(<h1>Hello, world!</h1>)])
		end
	end
end
