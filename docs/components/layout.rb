# frozen_string_literal: true

module Components
	class Layout < Phlex::View
		register_element :style

		def initialize(title:)
			@title = title
		end

		def template(&block)
			doctype

			html do
				head do
					meta charset: "utf-8"
					title { @title }
					link href: "/application.css", rel: "stylesheet"
					style { raw Rouge::Theme.find("github").render(scope: ".highlight") }
				end

				body class: "p-12" do
					div class: "max-w-screen-lg mx-auto grid grid-cols-4 gap-10" do
						header class: "col-span-1" do
							a(href: "/", class: "block") { img src: "/assets/logo.png", width: "150" }

							nav do
								ul do
									li { a(href: "/") { "Introduction" } }
									li { a(href: "/templates") { "Templates" } }
									li { a(href: "/views") { "Views" } }
									li { a(href: "/rails-integration") { "Rails integration" } }
									li { a(href: "https://github.com/joeldrapper/phlex") { "Source code" } }
								end
							end
						end

						main(class: "col-span-3", &block)

						footer class: "text-sm text-right col-span-4 py-10"
					end
				end
			end
		end
	end
end
