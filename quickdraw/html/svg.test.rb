# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		svg do |s|
			s.path(d: "321")
		end
	end
end

test "rendering SVG inside HTML components" do
	expect(Example.call) == %(<svg><path d="321"></path></svg>)
end
