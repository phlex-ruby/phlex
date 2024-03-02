class Example < Phlex::HTML
	def view_template
		div {
			h1(id: "target") { "Hello" }
		}
	end
end

describe Phlex::HTML do
	it "renders the view template" do
		expect(Example.new.call(fragment: "target")).to be == ("<h1 id=\"target\">Hello</h1>")
	end
end
