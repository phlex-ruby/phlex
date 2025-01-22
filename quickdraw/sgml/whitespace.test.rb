# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "whitespae between" do
	output = phlex do
		div
		whitespace
		div
	end

	assert_equal_html output, %(<div></div> <div></div>)
end

test "whitespae around" do
	output = phlex do
		div
		whitespace { div }
		div
	end

	assert_equal_html output, %(<div></div> <div></div> <div></div>)
end
