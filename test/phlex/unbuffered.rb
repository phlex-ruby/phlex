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
		a = Phlex::Unbuffered.call(Example.new).__class__
		b = Phlex::Unbuffered.call(Example.new).__class__

		expect(a).to be == b
	end

	it "captures the underlying view output methods" do
		captured_output = nil

		output = Example.call do |v|
			unbuffered_view = Phlex::Unbuffered.call(v)
			captured_output = unbuffered_view.foo
			nil
		end

		expect(captured_output).to be == "<h1>Foo</h1>"
		expect(output).to be == ""
	end

	it "delegates #send" do
		view = Example.new
		unbuffered_view = Phlex::Unbuffered.call(view)
		expect(view).to receive(:send).with(:bar)

		unbuffered_view.send(:bar)
	end
end
