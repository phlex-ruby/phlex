# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	Phlex::HTML::STANDARD_ELEMENTS.each do |method_name, tag|
		with "<#{tag}> called with an underscore prefix while overridden" do
			view do
				define_method :template do
					send("_#{method_name}")
				end

				define_method method_name do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{tag}></#{tag}>)
			end
		end

		with "<#{tag}> with block content and attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled><h1>Hello</h1></#{tag}>)
			end
		end

		with "<#{tag}> with block text content and attributes" do
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
		with "<#{tag}> called with an underscore prefix while overridden" do
			view do
				define_method :template do
					send("_#{method_name}")
				end

				define_method method_name do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{tag}>)
			end
		end

		with "<#{tag}> with attributes" do
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
