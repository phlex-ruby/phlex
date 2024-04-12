# frozen_string_literal: true

class Example < Phlex::HTML
	def before_template
		h1 { "Before" }
	end

	def view_template
		h2 { "Hello World" }
	end

	def after_template
		h3 { "After" }
	end
end

test do
	expect(Example.call) == ("<h1>Before</h1><h2>Hello World</h2><h3>After</h3>")
end
