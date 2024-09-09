# frozen_string_literal: true

class App < Phlex::HTML
	def view_template
		render Example do |e|
			e.slot(&Sub.new)
		end
	end
end

class Example < Phlex::HTML
	def view_template(&)
		article(&)
	end

	def slot(&)
		render(&)
	end
end

class Sub < Phlex::HTML
	def view_template
		h1 { "Sub" }
	end
end

test do
	expect(App.new.call) == "<article><h1>Sub</h1></article>"
end
