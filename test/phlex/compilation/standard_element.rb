# frozen_string_literal: true

require "test_helper"
require "standard_element"

describe Phlex::Compiler do
	include CompilerTestHelpers

	it "supports standard elements" do
		with_parens = compile(Fixtures::StandardElement::WithParens)
		without_parens = compile(Fixtures::StandardElement::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<h1></h1>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end

	it "supports standard elements with attributes" do
		with_parens = compile(Fixtures::StandardElement::WithAttributes::WithParens)
		without_parens = compile(Fixtures::StandardElement::WithAttributes::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<h1" << fetch_attrs(class: "font-bold") << "></h1>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end

	it "supports standard elements with brace block" do
		with_parens = compile(Fixtures::StandardElement::WithBraceBlock::WithParens)
		without_parens = compile(Fixtures::StandardElement::WithBraceBlock::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<h1>Hi</h1>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end

	it "supports standard elements with brace block and attributes" do
		output = compile(Fixtures::StandardElement::WithBraceBlock::WithAttributes)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1" << fetch_attrs(class: "font-bold") << ">Hi</h1>"
			end
		RUBY
	end

	it "supports standard elements with do block" do
		with_parens = compile(Fixtures::StandardElement::WithDoBlock::WithParens)
		without_parens = compile(Fixtures::StandardElement::WithDoBlock::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<h1>Hi</h1>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end

	it "supports standard elements with do block with attributes" do
		with_parens = compile(Fixtures::StandardElement::WithDoBlock::WithAttributes::WithParens)
		without_parens = compile(Fixtures::StandardElement::WithDoBlock::WithAttributes::WithoutParens)

		expected = <<~RUBY
			def template
				@_target << "<h1" << fetch_attrs(class: "font-bold") << ">Hi</h1>"
			end
		RUBY

		expect(with_parens.first).to be == expected
		expect(without_parens.first).to be == expected
	end
end
