# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		h1 { "Hello" }
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
			with "simple inline tag" do
				view do
					def view_template
						h1 "Hello", class: "title"
					end
				end

				it "renders a new instance of that view" do
					expect(output).to be == "<h1 class=\"title\">Hello</h1>"
				end
			end

			with "regular nesting" do
				view do
					def view_template
						div class: "first" do
							div class: "second" do
								div "Hello", class: "third"
							end
						end
					end
				end

				it "renders a new instance of that view" do
					expect(output).to be == "<div class=\"first\"><div class=\"second\"><div class=\"third\">Hello</div></div></div>"
				end
			end

			with "contain block" do
				view do
					def block_div
						proc { div "Hello" }
					end

					def view_template
						div block_div
					end
				end

				it "raise argument error" do
					expect { output }.to raise_exception(ArgumentError, message: be == "Only String allowed for inline tags content")
				end
			end

			with "contain nil argument" do
				view do
					def view_template
						h1 div "Hello"
					end
				end

				it "raise argument error" do
					expect { output }.to raise_exception(ArgumentError, message: be == "Only String allowed for inline tags content")
				end
			end

			with "both block and inline arguments" do
				view do
					def view_template
						h1("Hello") { "Hello" }
					end
				end

				it "raise argument error" do
					expect { output }.to raise_exception(ArgumentError, message: be == "Using inline and block syntax at same time is forbidden")
				end
			end

			with "non string content" do
				view do
					def view_template
						div :hello, class: "first"
					end
				end

				it "raises argument error" do
					expect { output }.to raise_exception(ArgumentError, message: be == "Only String allowed for inline tags content")
				end
			end
		end
	end
end
