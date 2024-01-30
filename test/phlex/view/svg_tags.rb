# frozen_string_literal: true

describe Phlex::SVG do
	extend ViewHelper

	Phlex::SVG::StandardElements.registered_elements.each do |method_name, tag|
		with "<#{tag}> called with an underscore prefix while overridden" do
			svg_view do
				define_method :view_template do
					send("_#{method_name}")
				end

				define_method tag do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{tag}></#{tag}>)
			end
		end

		with "<#{tag}> with block content and attributes" do
			svg_view do
				define_method :view_template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { text { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled><text>Hello</text></#{tag}>)
			end
		end

		with "<#{tag}> with block text content and attributes" do
			svg_view do
				define_method :view_template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
			end
		end
	end
end
