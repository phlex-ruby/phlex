# frozen_string_literal: true

require "components"

class Example < Phlex::HTML
	include Components

	def template
		SayHi("Joel", times: 2) { "Inside" }
		Components::SayHi("Will", times: 1) { "Inside" }
	end
end

# This feature is only supported in Ruby 3.2 or later.
if RUBY_VERSION >= "3.2"
	describe Phlex::Kit do
		it "defines methods for its components" do
			expect(Example.new.call).to be == %(<article><h1>Hi Joel</h1><h1>Hi Joel</h1>Inside</article><article><h1>Hi Will</h1>Inside</article>)
		end
	end
end
