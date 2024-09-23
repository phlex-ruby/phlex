# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "whitespae between" do
	expect(
		phlex {
			div
			whitespace
			div
		},
	) == %(<div></div> <div></div>)
end

test "whitespae around" do
	expect(
		phlex {
			div
			whitespace { div }
			div
		},
	) == %(<div></div> <div></div> <div></div>)
end
