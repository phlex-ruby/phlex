# frozen_string_literal: true

require "test_helper"
require "void_element"

describe Phlex::Compiler do
	include CompilerTestHelpers

	it "supports void elements" do
		with_parens = compile(Fixtures::VoidElement::WithParens)
		without_parens = compile(Fixtures::VoidElement::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<img>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end

	it "supports void elements with attributes" do
		with_parens = compile(Fixtures::VoidElement::WithAttributes::WithParens)
		without_parens = compile(Fixtures::VoidElement::WithAttributes::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<img" << fetch_attrs(class: "a b c") << ">"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end
end
