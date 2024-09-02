# frozen_string_literal: true

class ExampleComponent < Phlex::HTML
	def view_template(&)
		div(&)
	end
end

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
			render ExampleComponent.new { "Should not render" }
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

class WithCaptureBlock < Phlex::HTML
	def view_template
		h1(id: "before") { "Before" }
		div(id: "around") do
			capture do
				h1(id: "inside") { "Inside" }
			end
		end
		h1(id: "after") { "After" }
	end
end

test "renders the just the target fragment" do
	expect(
		StandardElementExample.new.call(fragments: ["target"]),
	) == %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1>)
end

test "works with void elements" do
	expect(
		VoidElementExample.new.call(fragments: ["target"]),
	) == %(<img id="target" src="image.jpg">)
end

test "supports multiple fragments" do
	expect(
		StandardElementExample.new.call(fragments: ["target", "image"]),
	) == %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1><img id="image" src="after.jpg">)
end

test "halts early after all fragments are found" do
	called = false
	checker = -> { called = true }
	StandardElementExample.new(checker).call(fragments: ["target"])
	expect(called) == false
end

test "with a capture block doesn't render the capture block" do
	expect(
		WithCaptureBlock.new.call(fragments: ["after"]),
	) == %(<h1 id="after">After</h1>)
end

test "with a capture block renders the capture block when selected" do
	expect(
		WithCaptureBlock.new.call(fragments: ["around"]),
	) == %(<div id="around">&lt;h1 id=&quot;inside&quot;&gt;Inside&lt;/h1&gt;</div>)
end

test "with a capture block doesn't select from the capture block" do
	expect(
		WithCaptureBlock.new.call(fragments: ["inside"]),
	) == ""
end
