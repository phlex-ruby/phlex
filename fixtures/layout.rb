# frozen_string_literal: true

module Example
	class LayoutComponent < Phlex::HTML
		def initialize(title: "Example")
			@title = title
		end

		def view_template(&block)
			html do
				head do
					title { @title }
					meta name: "viewport", content: "width=device-width,initial-scale=1"
					link href: "/assets/tailwind.css", rel: "stylesheet"
				end

				body class: "bg-zinc-100" do
					nav class: "p-5", id: "main_nav" do
						ul do
							li(class: "p-5") { a(href: "/") { "Home" } }
							li(class: "p-5") { a(href: "/about") { "About" } }
							li(class: "p-5") { a(href: "/contact") { "Contact" } }
						end
					end

					div class: "container mx-auto p-5", &block
				end
			end
		end
	end
end
