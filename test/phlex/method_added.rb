# frozen_string_literal: true

class Example < Phlex::HTML
end

describe Phlex::HTML do
	it "raises if you try to redefine an underscored method" do
		expect { Example.define_method(:_h1) { nil } }.to raise_exception(Phlex::NameError)
	end

	it "doesn't raise if you define a new underscored method" do
		Example.define_method(:_some_random_method) { nil }
	end
end
