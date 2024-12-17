# frozen_string_literal: true

include Phlex::Helpers

test "single binding" do
	output = grab(class: "foo")
	assert_equal output, "foo"
end

test "multiple bindings" do
	output = grab(class: "foo", if: "bar")
	assert_equal output, ["foo", "bar"]
end
