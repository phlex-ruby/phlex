# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "safe attribute values" do
	expect(
		phlex {
			a(
				onclick: safe("window.history.back()"),
				href: safe("javascript:window.history.back()"),
			)
		},
	) == %(<a onclick="window.history.back()" href="javascript:window.history.back()"></a>)
end

test "element content blocks that return safe values" do
	expect(
		phlex {
			script {
				safe(%(console.log("Hello World");))
			}
		},
	) == %(<script>console.log("Hello World");</script>)
end

test "with invalid input" do
	expect {
		phlex {
			script { safe(123) }
		}
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Expected a String."
	end
end
