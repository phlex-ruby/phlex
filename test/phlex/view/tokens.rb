# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	with "conditional classes" do
		with "symbol conditionals" do
			view do
				def template
					a "Home", href: "/", **classes("a", "b", "c", active?: "active", primary?: "primary")
				end

				def active?
					false
				end

				def primary?
					true
				end
			end

			it "works" do
				expect(output).to be ==
					%(<a href="/" class="a b c primary">Home</a>)
			end
		end

		with "proc conditionals" do
			view do
				def template
					a "Home", href: "/", **classes("a", "b", "c",
						-> { true } => "true",
						-> { false } => "false")
				end
			end

			it "works" do
				expect(output).to be ==
					%(<a href="/" class="a b c true">Home</a>)
			end
		end
	end
end
