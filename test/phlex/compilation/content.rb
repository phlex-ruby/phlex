# frozen_string_literal: true

require "content"

describe Phlex::Compiler do
	include CompilerTestHelpers

	it "supports string content" do
		output = compile(Fixtures::Content::BareString)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1>Hello</h1>"
			end
		RUBY
	end

	it "supports symbol content" do
		output = compile(Fixtures::Content::Symbol)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1>hello</h1>"
			end
		RUBY
	end

	it "supports float content" do
		output = compile(Fixtures::Content::Float)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1>1.2</h1>"
			end
		RUBY
	end

	it "supports integer content" do
		output = compile(Fixtures::Content::Integer)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1>1</h1>"
			end
		RUBY
	end

	it "supports nested tags" do
		output = compile(Fixtures::Content::NestedTags)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<article><h1>Inside</h1></article>"
			end
		RUBY
	end

	it "supports variable content" do
		output = compile(Fixtures::Content::Variable)

		expect(output.first).to be == <<~RUBY
			def template
				greeting = "Hello"
				@_target << "<h1>" << Hescape.escape_html(greeting) << "</h1>"
			end
		RUBY
	end

	it "supports instance variable content" do
		output = compile(Fixtures::Content::InstanceVariable)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<h1>" << Hescape.escape_html(@hello) << "</h1>"
			end
		RUBY
	end

	it "supports non-mutating nested content" do
		output = compile(Fixtures::Content::NonMutatingNestedContent)

		expect(output.first).to be == <<~RUBY
			def template
				@_target << "<div>"
				yield_content { say_hello }
				@_target << "</div>"
			end
		RUBY
	end
end
