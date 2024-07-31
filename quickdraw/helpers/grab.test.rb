# frozen_string_literal: true

include Phlex::Helpers

test "supports many bindings" do
	output = grab(class: "foo", if: "bar")
	expect(output) == ["foo", "bar"]
end

test "supports single binding" do
	output = grab(class: "foo")
	expect(output) == "foo"
end
