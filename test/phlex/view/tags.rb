# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	Phlex::HTML::STANDARD_ELEMENTS.each do |method_name, tag|
		with "<#{method_name}> with block content and attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled><h1>Hello</h1></#{tag}>)
			end
		end

		with "<#{method_name}> with block text content and attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
			end
		end
	end

	Phlex::HTML::VOID_ELEMENTS.each do |method_name, tag|
		with "<#{method_name}> with attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false)
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled>)
			end
		end
	end
end
