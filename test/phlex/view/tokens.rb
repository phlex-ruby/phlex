# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "implicit class binding" do
		with "class: keyword argument" do
			view do
				def view_template
					red(class: "buzz")
				end

				def red(class:)
					div(class: tokens("fizz", class:))
				end
			end

			it "implicitly binds class: keyword argument" do
				expect(output).to be == %(<div class="fizz buzz"></div>)
			end
		end

		with "endless argumens (...)" do
			view do
				def view_template
					red(class: "buzz")
				end

				def red(...)
					div(class: tokens("fizz", class:))
				end
			end

			it "raises error" do
				expect{ output }.to raise_exception ArgumentError,
					message: be == "Implicit class binding is not supported. Use the class: keyword argument."
			end
		end
	end

	with "conditional classes" do
		with "symbol conditionals" do
			view do
				def view_template
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
				def view_template
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
				def view_template
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
				def view_template
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

		with "nils and empty strings" do
			view do
				def view_template
					div(class: tokens("", nil, false, "foo", "", nil, false, "bar", "", nil, false))
				end
			end

			it "reoves the redundant whitespace" do
				expect(output).to be == %(<div class="foo bar"></div>)
			end
		end
	end
end
