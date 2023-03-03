# frozen_string_literal: true

describe Phlex::SVG do
	extend ViewHelper

	Phlex::SVG::StandardElements.send(:slow_registered_elements).each do |method_name|
		with "<#{method_name}> called with an underscore prefix while overridden" do
			svg_view do
				define_method :template do
					send("_#{method_name}")
				end

				define_method method_name do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{method_name}></#{method_name}>)
			end
		end

		with "<#{method_name}> with block content and attributes" do
			svg_view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { text { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{method_name} class="class" id="id" disabled><text>Hello</text></#{method_name}>)
			end
		end

		with "<#{method_name}> with block text content and attributes" do
			svg_view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{method_name} class="class" id="id" disabled>content</#{method_name}>)
			end
		end
	end
end
