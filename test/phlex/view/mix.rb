# frozen_string_literal: true

describe Phlex::Helpers do
	include Phlex::Helpers

	it "supports string concatination" do
		output = mix({ class: "foo" }, { class: "bar" })
		expect(output).to be == { class: "foo bar" }
	end

	it "supports string override" do
		output = mix({ class: "foo" }, { class!: "bar" })
		expect(output).to be == { class: "bar" }
	end

	it "supports array concatination" do
		output = mix({ class: ["foo"] }, { class: ["bar"] })
		expect(output).to be == { class: ["foo", "bar"] }
	end

	it "supports array override" do
		output = mix({ class: ["foo"] }, { class!: ["bar"] })
		expect(output).to be == { class: ["bar"] }
	end

	it "supports hash concatination" do
		output = mix(
			{ data: { controller: "foo" } },
			{ data: { controller: "bar" } }
		)

		expect(output).to be == { data: { controller: "foo bar" } }
	end

	it "supports hash override" do
		output = mix(
			{ data: { controller: "foo" } },
			{ data!: { controller: "bar" } }
		)

		expect(output).to be == { data: { controller: "bar" } }
	end

	it "supports mixing between arrays and strings" do
		output = mix({ class: ["foo"] }, { class: "bar" })

		expect(output).to be == { class: ["foo", "bar"] }

		output = mix({ class: "foo" }, { class: ["bar"] })

		expect(output).to be == { class: ["foo", "bar"] }
	end

	it "supports mixing between sets and strings" do
		output = mix({ class: Set["foo"] }, { class: "bar" })

		expect(output).to be == { class: Set["foo", "bar"] }

		output = mix({ class: "foo" }, { class: Set["bar"] })

		expect(output).to be == { class: Set["foo", "bar"] }
	end

	it "supports mixing between arrays and sets, keeping the less restrictive type" do
		output = mix({ class: ["foo"] }, { class: Set["bar"] })

		expect(output).to be == { class: ["foo", "bar"] }

		output = mix({ class: Set["foo"] }, { class: ["bar"] })

		expect(output).to be == { class: ["foo", "bar"] }
	end

	it "gracefully handles mixing with nils" do
		output = mix({ class: "foo" }, { class: nil })

		expect(output).to be == { class: "foo" }

		output = mix({ class: nil }, { class: "foo" })

		expect(output).to be == { class: "foo" }
	end
end
