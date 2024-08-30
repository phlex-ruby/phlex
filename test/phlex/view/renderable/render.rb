# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		h1 { "Hello" }
	end
end

class InlineExample < Phlex::HTML
	def view_template
		div class: "first" do
			div class: "second" do
				div "Hello", class: "third"
			end
		end
	end
end

class InlineNestedExample < Phlex::HTML
	# It's a specific case so it should be wrapped properly to keep execution sequence
	def tag_method_wrapper(method_name, inline_content, **attributes)
		proc do
			public_send(method_name, **attributes) do
				inline_content
			end
		end
	end

	def view_template
		div class: "first" do
			div class: "second" do
				div(tag_method_wrapper(:div, "Hello", class: "fourth"), class: "third")
			end
		end
	end
end

describe Phlex::HTML do
	extend ViewHelper

	describe "#render" do
		with "a view class" do
			view do
				def view_template
					render Example
				end
			end

			it "renders a new instance of that view" do
				expect(output).to be == "<h1>Hello</h1>"
			end
		end

		with "another view" do
			other_view = Class.new Phlex::HTML do
				def view_template(&block)
					div(&block)
				end
			end

			with "markup" do
				view do
					define_method :view_template do
						render(other_view.new) do
							h1 { "Hi!" }
						end
					end
				end

				it "renders the other view" do
					expect(output).to be == "<div><h1>Hi!</h1></div>"
				end
			end

			with "text" do
				view do
					define_method :view_template do
						render(other_view.new) { "Hello world!" }
					end
				end

				it "renders the other view" do
					expect(output).to be == "<div>Hello world!</div>"
				end
			end

			with "0-argument lambda" do
				view do
					define_method :view_template do
						render -> { h1 { "Hi" } }
					end
				end

				it "renders the lambda" do
					expect(output).to be == "<h1>Hi</h1>"
				end
			end

			with "1-argument lambda" do
				view do
					define_method :view_template do
						render -> (_view) { h1 { "Hi" } }
					end
				end

				it "renders the lambda" do
					expect(output).to be == "<h1>Hi</h1>"
				end
			end

			with "multi-argument proc" do
				view do
					define_method :view_template do
						render proc { |_a, _b, _c| h1 { "Hi" } }
					end
				end

				it "renders the lambda" do
					expect(output).to be == "<h1>Hi</h1>"
				end
			end
		end

		with "inline tag method call" do
			with "contain block" do
				view do
					def view_template
						render InlineNestedExample
					end
				end

				it "renders a new instance of that view" do
					expect(output).to be == "<div class=\"first\"><div class=\"second\"><div class=\"third\"><div class=\"fourth\">Hello</div></div></div></div>"
				end
			end

			with "regular nesting" do
				view do
					def view_template
						render InlineExample
					end
				end

				it "renders a new instance of that view" do
					expect(output).to be == "<div class=\"first\"><div class=\"second\"><div class=\"third\">Hello</div></div></div>"
				end
			end
		end
	end
end
