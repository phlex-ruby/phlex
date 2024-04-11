# frozen_string_literal: true

require "components"

class Example < Phlex::HTML
	include Components

	def view_template
		SayHi("Joel", times: 2) { "Inside" }
		Components::SayHi("Will", times: 1) { "Inside" }
	end
end

# This feature is only supported in Ruby 3.2 or later.
if Phlex::SUPPORTS_FIBER_STORAGE
	describe Phlex::Kit do
		test "raises when you try to render a component outside of a rendering context" do
			expect { Components::SayHi() }.to_raise(RuntimeError) do |error|
				expect(error.message) == "You can't call `SayHi' outside of a Phlex rendering context."
			end
		end

		test "defines methods for its components" do
			expect(Example.new.call) == %(<article><h1>Hi Joel</h1><h1>Hi Joel</h1>Inside</article><article><h1>Hi Will</h1>Inside</article>)
		end
	end
end
