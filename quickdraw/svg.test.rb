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
