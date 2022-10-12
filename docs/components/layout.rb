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

				body class: "text-stone-700" do
					header class: "border-b py-4 px-10 flex justify-between items-center" do
						a(href: "/", class: "block") { img src: "/assets/logo.png", width: "100" }

						nav(class: "text-stone-500 font-medium") do
							ul(class: "flex space-x-8") do
								li { a(href: "https://github.com/sponsors/joeldrapper") { "💖️ Sponsor" } }
								li { a(href: "https://github.com/joeldrapper/phlex") { "GitHub" } }
							end
						end
					end

					div class: "grid grid-cols-4 divide-x" do
						nav class: "col-span-1 px-10 py-5" do
							h2(class: "text-lg font-semibold pt-5") { "Guide" }

							ul do
								render Nav::Item.new("Introduction", to: Pages::Index, active_page: @_parent)
								render Nav::Item.new("Views", to: Pages::Views, active_page: @_parent)
								render Nav::Item.new("Templates", to: Pages::Templates, active_page: @_parent)
								render Nav::Item.new("Helpers", to: Pages::Helpers, active_page: @_parent)
							end

							h2(class: "text-lg font-semibold pt-5") { "Rails" }

							ul do
								render Nav::Item.new("Getting started", to: Pages::Rails::GettingStarted, active_page: @_parent)
								render Nav::Item.new("Rendering views", to: Pages::Rails::RenderingViews, active_page: @_parent)
								render Nav::Item.new("Layouts", to: Pages::Rails::Layouts, active_page: @_parent)
								render Nav::Item.new("Helpers", to: Pages::Rails::Helpers, active_page: @_parent)
								render Nav::Item.new("Migrating to Phlex", to: Pages::Rails::Migrating, active_page: @_parent)
							end
						end

						main class: "col-span-3 px-20 px-10 py-5" do
							div(class: "max-w-prose prose", &block)
						end
					end

					footer class: "border-t p-20 flex justify-center text-stone-500 text-lg font-medium" do
						a(href: "https://github.com/sponsors/joeldrapper") { "Sponsor this project 💖" }
					end
				end
			end
		end
	end
end
