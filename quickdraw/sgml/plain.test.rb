# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "with string" do
	output = phlex { plain "Hello, World!" }
	assert_equal_html output, "Hello, World!"
end

test "with symbol" do
	output = phlex { plain :hello_world }
	assert_equal_html output, "hello_world"
end

test "with integer" do
	output =	phlex { plain 42 }
	assert_equal_html output, "42"
end

test "with float" do
	output = phlex { plain 3.14 }
	assert_equal_html output, "3.14"
end

test "with nil" do
	output = phlex { plain nil }
	assert_equal_html output, ""
end

test "with invalid arguments" do
	assert_raises(Phlex::ArgumentError) do
		phlex { plain [] }
	end
end
