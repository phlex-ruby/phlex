# frozen_string_literal: true

describe Phlex::HTML do
	def build_component_with_template(&block)
		Class.new(Phlex::HTML) do
			define_method(:view_template, block)
		end
	end

	it "renders to_s class" do
		klass = Class.new { define_method(:to_s, -> { "to_s" }) }
		component = build_component_with_template do
			div class: klass.new
		end

		expect(component.call).to be == %(<div class="to_s"></div>)
	end

	it "renders to_str class" do
		klass = Class.new { define_method(:to_str, -> { "to_str" }) }
		component = build_component_with_template do
			div class: klass.new
		end

		expect(component.call).to be == %(<div class="to_str"></div>)
	end

	it "renders to_phlex_attribute_value class" do
		klass = Class.new { define_method(:to_phlex_attribute_value, -> { "to_phlex_attribute_value" }) }
		component = build_component_with_template do
			div class: klass.new
		end

		expect(component.call).to be == %(<div class="to_phlex_attribute_value"></div>)
	end

	it "renders phlex attribute value according to method call precedence" do
		to_phlex_attribute_value_klass = Class.new { define_method(:to_phlex_attribute_value, -> { "to_phlex_attribute_value" }) }
		to_str_klass = Class.new(to_phlex_attribute_value_klass) { define_method(:to_str, -> { "to_str" }) }
		to_s_klass = Class.new(to_str_klass) { define_method(:to_s, -> { "to_s" }) }
		component = build_component_with_template do
			div class: to_s_klass.new
		end

		expect(component.call).to be == %(<div class="to_phlex_attribute_value"></div>)
	end
end
