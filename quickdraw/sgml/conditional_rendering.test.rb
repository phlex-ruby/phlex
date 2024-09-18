# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize(render:)
		@render = render
	end

	def render? = @render

	def view_template
		h1 { "Hello" }
	end
end

test do
	expect(Example.new(render: true).call) == "<h1>Hello</h1>"
	expect(Example.new(render: false).call) == ""
end
