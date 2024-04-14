# frozen_string_literal: true

include Phlex::Helpers

test "supports string concatination" do
	output = mix({ class: "foo" }, { class: "bar" })
	expect(output) == { class: "foo bar" }
end

test "supports string override" do
	output = mix({ class: "foo" }, { class!: "bar" })
	expect(output) == { class: "bar" }
end

test "supports array concatination" do
	output = mix({ class: ["foo"] }, { class: ["bar"] })
	expect(output) == { class: ["foo", "bar"] }
end

test "supports array override" do
	output = mix({ class: ["foo"] }, { class!: ["bar"] })
	expect(output) == { class: ["bar"] }
end

test "supports hash concatination" do
	output = mix(
		{ data: { controller: "foo" } },
			{ data: { controller: "bar" } }
	)

	expect(output) == { data: { controller: "foo bar" } }
end

test "supports hash override" do
	output = mix(
		{ data: { controller: "foo" } },
			{ data!: { controller: "bar" } }
	)

	expect(output) == { data: { controller: "bar" } }
end

test "supports mixing between arrays and strings" do
	output = mix({ class: ["foo"] }, { class: "bar" })

	expect(output)

	output = mix({ class: "foo" }, { class: ["bar"] })

	expect(output) == { class: ["foo", "bar"] }
end

test "supports mixing between sets and strings" do
	output = mix({ class: Set["foo"] }, { class: "bar" })

	expect(output)
	{ class: Set["foo", "bar"] }

	output = mix({ class: "foo" }, { class: Set["bar"] })

	expect(output) == { class: Set["foo", "bar"] }
end

test "supports mixing between arrays and sets, keeping the less restrictive type" do
	output = mix({ class: ["foo"] }, { class: Set["bar"] })

	expect(output)

	output = mix({ class: Set["foo"] }, { class: ["bar"] })

	expect(output) == { class: ["foo", "bar"] }
end

test "gracefully handles mixing with nils" do
	output = mix({ class: "foo" }, { class: nil })

	expect(output)

	output = mix({ class: nil }, { class: "foo" })

	expect(output) == { class: "foo" }
end
