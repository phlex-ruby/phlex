# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		html {
			head {
				doctype
			}
		}
	end
end

test do
	expect(Example.call) == "<html><head><!doctype html></head></html>"
end
