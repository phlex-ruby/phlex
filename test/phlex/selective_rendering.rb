# frozen_string_literal: true

class StandardElementExample < Phlex::HTML
	def view_template
		div {
			h1 { "Before" }
			img(src: "before.jpg")
			whitespace
			comment { "This is a comment" }
			h1(id: "target") {
				plain "Hello"
				strong { "World" }
				img(src: "image.jpg")
			}
			img(src: "after.jpg")
			h1 { "After" }
		}
	end
end

class VoidElementExample < Phlex::HTML
	def view_template
		div {
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
			h1 { "After" }
		}
	end
end

describe Phlex::HTML do
	it "renders the just the target fragment" do
		expect(
			StandardElementExample.new.call(fragment: "target")
		).to be == %(<h1 id="target">Hello<strong>World</strong><img src="image.jpg"></h1>)
	end

	it "works with void elements" do
		expect(
			VoidElementExample.new.call(fragment: "target")
		).to be == %(<img id="target" src="image.jpg">)
	end
end
