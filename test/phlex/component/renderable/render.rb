# frozen_string_literal: true

require "test_helper"

Example = Class.new(Phlex::Component)

describe Phlex::Component do
	extend ComponentHelper

	with "#render" do
		with "a component class" do
			component do
				def template
					render Example
				end
			end

			it "raises an ArgumentError" do
				expect { output }.to raise_exception ArgumentError, message:
										"You tried to render the Phlex component class: #{Example.name} but you probably meant to render an instance of that class instead."
			end
		end

		with "another component" do
			other_component = Class.new Phlex::Component do
				def template(&block)
					div(&block)
				end
			end

			with "markup" do
				component do
					define_method :template do
						render(other_component.new) do
							h1 "Hi!"
						end
					end
				end

				it "renders the other component" do
					expect(output).to be == "<div><h1>Hi!</h1></div>"
				end
			end

			with "text" do
				component do
					define_method :template do
						render(other_component.new) { "Hello world!" }
					end
				end

				it "renders the other component" do
					expect(output).to be == "<div>Hello world!</div>"
				end
			end
		end
	end
end
