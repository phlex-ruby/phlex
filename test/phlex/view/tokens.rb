# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "conditional classes" do
		with "symbol conditionals" do
			view do
				def template
					a href: "/", **classes("a", "b", "c", active?: "active", primary?: ["primary", "d"]) do
						"Home"
					end
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
					%(<a href="/" class="a b c primary d">Home</a>)
			end
		end

		with "proc conditionals" do
			view do
				def template
					a href: "/", **classes("a", "b", "c",
						-> { true } => "true",
						-> { false } => "false") do
						"Home"
					end
				end
			end

			it "works" do
				expect(output).to be ==
					%(<a href="/" class="a b c true">Home</a>)
			end
		end

		with "negative conditionals" do
			view do
				def template
					a href: "/", **classes("a", "b", "c",
						active?: {
							then: "active",
							else: "inactive"
						}) do
						"Home"
					end
				end

				def active?
					false
				end
			end

			it "works" do
				expect(output).to be ==
					%(<a href="/" class="a b c inactive">Home</a>)
			end
		end

		with "no truthy conditionals" do
			view do
				def template
					a href: "/", **classes(
						active?: {
							then: "active"
						}
					) do
						"Home"
					end
				end

				def active?
					false
				end
			end

			it "works" do
				expect(output).to be ==
					%(<a href="/">Home</a>)
			end
		end
	end
end
