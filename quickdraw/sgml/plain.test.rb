# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "with string" do
	expect(
		phlex { plain "Hello, World!" },
	) == "Hello, World!"
end

test "with symbol" do
	expect(
		phlex { plain :hello_world },
	) == "hello_world"
end

test "with integer" do
	expect(
		phlex { plain 42 },
	) == "42"
end

test "with float" do
	expect(
		phlex { plain 3.14 },
	) == "3.14"
end

test "with nil" do
	expect(
		phlex { plain nil },
	) == ""
end

test "with invalid arguments" do
	expect { phlex { plain [] } }.to_raise(Phlex::ArgumentError)
end
