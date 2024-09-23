# frozen_string_literal: true

require "sgml_helper"
include SGMLHelper

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

test "rendering components via #to_proc" do
	expect(
		phlex {
			render Example do |e|
				e.slot(&Sub.new)
			end
		},
	) == "<article><h1>Sub</h1></article>"
end
