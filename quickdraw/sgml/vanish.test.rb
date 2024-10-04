# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

class Example < Phlex::HTML
	def before_template(&)
		vanish(&)
		super
	end

	def view_template
		h1 { @text }
	end

	def add_text(text)
		@text = text
	end
end

test "vanish the block in before_template" do
	expect(
		phlex {
			render Example do |e|
				e.add_text("From block")
			end
		},
	) == "<h1>From block</h1>"
end
