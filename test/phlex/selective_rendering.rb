# frozen_string_literal: true

class StandardElementExample < Phlex::HTML
	def initialize(execution_checker = -> {})
		@execution_checker = execution_checker
	end

	def view_template
		doctype
		div {
			comment { h1(id: "target") }
			h1 { "Before" }
			img(src: "before.jpg")
			whitespace
			comment { "This is a comment" }
			h1(id: "target") {
				plain "Hello"
				strong { "World" }
				img(src: "image.jpg")
			}
			@execution_checker.call
			strong { "Here" }
			img(id: "image", src: "after.jpg")
			h1(id: "target") { "After" }
		}
	end
end

class VoidElementExample < Phlex::HTML
	def view_template
		doctype
		div {
			comment { h1(id: "target") }
			h1 { "Before" }
			img(src: "before.jpg")
			whitespace
			comment { "This is a comment" }
			h1 {
				plain "Hello"
				strong { "World" }
				img(id: "target", src: "image.jpg")
			}
			img(src: "after.jpg")
			h1(id: "target") { "After" }
		}
	end
end

describe Phlex::HTML do
	it "renders the just the target fragment" do
		expect(
			StandardElementExample.new.call(fragments: ["target"])
		).to be == %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1>)
	end

	it "works with void elements" do
		expect(
			VoidElementExample.new.call(fragments: ["target"])
		).to be == %(<img id="target" src="image.jpg">)
	end

	it "supports multiple fragments" do
		expect(
			StandardElementExample.new.call(fragments: ["target", "image"])
		).to be == %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1><img id="image" src="after.jpg">)
	end

	it "halts early after all fragments are found" do
		called = false
		checker = -> { called = true }
		StandardElementExample.new(checker).call(fragments: ["target"])
		expect(called).to be == false
	end
end
