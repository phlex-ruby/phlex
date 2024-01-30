# frozen_string_literal: true

describe Phlex::SGML do
	it "warns when you define a template" do
		expect(Kernel).to receive(:warn)

		class Example < Phlex::HTML
			def template
				h1 { "Hello, world!" }
			end
		end

		expect(
			Example.new.call
		).to be == "<h1>Hello, world!</h1>"
	end
end
