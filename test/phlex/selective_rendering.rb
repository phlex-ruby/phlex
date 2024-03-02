class Example < Phlex::HTML
	def view_template
		div {
			h1 { "Before" }
			h1(id: "target") {
				plain "Hello"
				strong { "World" }
			}
			h1 { "After" }
		}
	end
end

describe Phlex::HTML do
	it "renders the view template" do
		expect(Example.new.call(fragment: "target")).to be == ("<h1 id=\"target\">Hello<strong>World</strong></h1>")
	end
end
