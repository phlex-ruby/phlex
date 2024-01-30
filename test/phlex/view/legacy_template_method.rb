# frozen_string_literal: true

describe Phlex::SGML do
	it "warns when you define a template" do
		expect(Kernel).to receive(:warn)

		example = Class.new(Phlex::HTML) do
			def template
				h1 { "Hello, world!" }
			end
		end

		expect(
			example.new.call
		).to be == "<h1>Hello, world!</h1>"
	end
end
