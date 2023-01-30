# frozen_string_literal: true

class Example < Phlex::HTML
	def template
		yield
	end

	def foo
		h1 { "Foo" }
	end

	def bar
		"bar"
	end
end

describe Phlex::Unbuffered do
	it "caches a decorator class for each class of view" do
		expect(Example.__unbuffered_class__).to be == Example.__unbuffered_class__
	end

	it "captures the underlying view output methods" do
		captured_output = nil

		output = Example.call do |view|
			captured_output = view.unbuffered.foo
			nil
		end

		expect(captured_output).to be == "<h1>Foo</h1>"
		expect(output).to be == ""
	end

	it "delegates #send" do
		view = Example.new
		expect(view).to receive(:send).with(:bar)

		view.unbuffered.send(:bar)
	end
end
