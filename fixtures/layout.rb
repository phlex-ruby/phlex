# frozen_string_literal: true

module Example
	class LayoutComponent < Phlex::View
		def initialize(title: "Example")
			@title = title
		end

		def template(&block)
			html do
				head do
					title @title
					meta name: "viewport", content: "width=device-width,initial-scale=1"
					link href: "/assets/tailwind.css", rel: "stylesheet"
				end

				body class: "bg-zinc-100" do
					nav class: "p-5", id: "main_nav" do
						ul do
							li(class: "p-5") { a "Home", href: "/" }
							li(class: "p-5") { a "About", href: "/about" }
							li(class: "p-5") { a "Contact", href: "/contact" }
						end
					end

					div class: "container mx-auto p-5", &block
				end
			end
		end
	end
end
