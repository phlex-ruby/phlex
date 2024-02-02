# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	Phlex::HTML::StandardElements.registered_elements.each do |method_name, tag|
		with "<#{tag}> called with an underscore prefix while overridden" do
			view do
				define_method :view_template do
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
				define_method :view_template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled><h1>Hello</h1></#{tag}>)
			end
		end

		with "<#{tag}> with block text content and attributes" do
			view do
				define_method :view_template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
			end
		end

		with "<#{tag}> with string attribute keys" do
			view do
				define_method :view_template do
					send(method_name, "attribute_with_underscore" => true) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} attribute_with_underscore>content</#{tag}>)
			end
		end

		with "<#{tag}> with hash attribute values" do
			view do
				define_method :view_template do
					send(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" }) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} aria-hidden data-turbo-frame="_top">content</#{tag}>)
			end
		end
	end

	Phlex::HTML::VoidElements.registered_elements.each do |method_name, tag|
		with "<#{tag}> called with an underscore prefix while overridden" do
			view do
				define_method :view_template do
					send("_#{method_name}")
				end

				define_method tag do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{tag}>)
			end
		end

		with "<#{tag}> with attributes" do
			view do
				define_method :view_template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false)
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} class="class" id="id" disabled>)
			end
		end

		with "<#{tag}> with string attribute keys" do
			view do
				define_method :view_template do
					send(method_name, "attribute_with_underscore" => true)
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} attribute_with_underscore>)
			end
		end

		with "<#{tag}> with hash attribute values" do
			view do
				define_method :view_template do
					send(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" })
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{tag} aria-hidden data-turbo-frame="_top">)
			end
		end
	end

	describe "Elements deprecation" do
		deprecated_methods = %i[param]

		deprecated_methods.each do |method_name|
			describe "##{method_name}" do
				view do
					define_method :view_template do
						send(method_name.to_sym)
					end
				end

				it "warns about `#{method_name}` deprecation" do
					message = capture_stderr { view.call }
					deprecation_message = "`#{method_name}` and `_#{method_name}` are deprecated and will be unsupported in Phlex 2.0. This HTML element is no longer recommended. Check out MDN web docs: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/#{method_name}."

					expect(message).to be == deprecation_message
				end
			end

			describe "#_#{method_name}" do
				view do
					define_method :view_template do
						send(:"_#{method_name}")
					end
				end

				it "warns about `_#{method_name}` deprecation" do
					message = capture_stderr { view.call }
					deprecation_message = "`#{method_name}` and `_#{method_name}` are deprecated and will be unsupported in Phlex 2.0. This HTML element is no longer recommended. Check out MDN web docs: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/#{method_name}."

					expect(message).to be == deprecation_message
				end
			end
		end
	end
end
