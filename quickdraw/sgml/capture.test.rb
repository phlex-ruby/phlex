# frozen_string_literal: true

class ExampleCaptureWithArguments < Phlex::HTML
	def yielder = yield("a", "b", "c")

	def view_template(...)
		h1(...)
	end
end

test "arguments are passed to the capture block" do
	output = ExampleCaptureWithArguments.new.call do |a, b, c|
		"#{a} #{b} #{c}"
	end

	expect(output) == "<h1>a b c</h1>"
end
