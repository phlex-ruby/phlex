# frozen_string_literal: true

class Example < Phlex::HTML
	def template
		h1 { "Hello" }
	end
end

describe Phlex::HTML do
	extend ViewHelper

	describe "#render" do
		with "a view class" do
			view do
				def template
					render Example
				end
			end

			it "renders a new instance of that view" do
				expect(output).to be == "<h1>Hello</h1>"
			end
		end

		with "another view" do
			other_view = Class.new Phlex::HTML do
				def template(&block)
					div(&block)
				end
			end

			with "markup" do
				view do
					define_method :template do
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
					define_method :template do
						render(other_view.new) { "Hello world!" }
					end
				end

				it "renders the other view" do
					expect(output).to be == "<div>Hello world!</div>"
				end
			end

			with "proc" do
				view do
					define_method :template do
						render proc { h1 { "Hi" } }
					end
				end

				it "renders the other view" do
					expect(output).to be == "<h1>Hi</h1>"
				end
			end
		end
	end
end
