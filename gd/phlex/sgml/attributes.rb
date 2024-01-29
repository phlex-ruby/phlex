# frozen_string_literal: true

include TestHelper

class ToPhlexAttributeValueable
	def to_phlex_attribute_value
		"to_phlex_attribute_value"
	end
end

class ToSable
	def to_s
		"to_s"
	end
end

class ToStrable
	def to_str
		"to_str"
	end
end

test "with symbol-keyed hash attributes" do
	component = build_component_with_template do
		div data: { name: { first_name: "Joel" } }
	end

	expect(component.new).to_render %(<div data-name-first-name="Joel"></div>)
end

test "with string-keyed hash attributes" do
	component = build_component_with_template do
		div data: { "name" => { "first_name" => "Joel" } }
	end

	expect(component.new).to_render %(<div data-name-first_name="Joel"></div>)
end

test "with an array of symbols and strings" do
	component = build_component_with_template do
		div class: ["bg-red-500", :rounded]
	end

	expect(component.new).to_render %(<div class="bg-red-500 rounded"></div>)
end

test "with a set of symbols and strings" do
	component = build_component_with_template do
		div class: Set.new(["bg-red-500", :rounded])
	end

	expect(component.new).to_render %(<div class="bg-red-500 rounded"></div>)
end

test "with a to_phlex_attribute_value-able object" do
	component = build_component_with_template do
		div class: ToPhlexAttributeValueable.new
	end

	expect(component.new).to_render %(<div class="to_phlex_attribute_value"></div>)
end

test "with a to_s-able object" do
	component = build_component_with_template do
		div class: ToSable.new
	end

	expect(component.new).to_render %(<div class="to_s"></div>)
end

test "with a to_str-able object" do
	component = build_component_with_template do
		div class: ToStrable.new
	end

	expect(component.new).to_render %(<div class="to_str"></div>)
end

test "with numeric integer/float" do
	component = build_component_with_template do
		input type: "range", min: 0, max: 10, step: 0.5
	end

	expect(component.new).to_render %(<input type="range" min="0" max="10" step="0.5">)
end

if RUBY_ENGINE == "ruby"
	context "with unique tag attributes" do
		let def component
			build_component_with_template do
				div class: SecureRandom.hex
			end
		end

		let def report
			component.call

			MemoryProfiler.report do
				2.times { component.call }
			end
		end

		test "doesn't leak memory" do
			expect(report.total_retained) == 0
		end
	end
end
