# frozen_string_literal: true

require "components"

class Example < Phlex::HTML
	include Components

	def view_template
		SayHi("Joel", times: 2) { "Inside" }
		Components::SayHi("Will", times: 1) { "Inside" }
	end
end

test "raises when you try to render a component outside of a rendering context" do
	expect { Components::SayHi("Joel") }.to_raise(RuntimeError) do |error|
		expect(error.message) == "You can't call `SayHi' outside of a Phlex rendering context."
	end
end

test "defines methods for its components" do
	expect(Example.new.call) == %(<article><h1>Hi Joel</h1><h1>Hi Joel</h1>Inside</article><article><h1>Hi Will</h1>Inside</article>)
end
