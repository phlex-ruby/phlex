# frozen_string_literal: true

class Example < Phlex::SVG
	def view_template
		svg do
			path(d: "123")
		end
	end
end

test do
	expect(Example.call) == %(<svg><path d="123"></path></svg>)
end

test "content_type" do
	component = Class.new(Phlex::SVG)
	expect(component.new.content_type) == "image/svg+xml"
end
