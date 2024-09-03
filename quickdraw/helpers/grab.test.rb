# frozen_string_literal: true

include Phlex::Helpers

test "single binding" do
	output = grab(class: "foo")
	expect(output) == "foo"
end

test "multiple bindings" do
	output = grab(class: "foo", if: "bar")
	expect(output) == ["foo", "bar"]
end
