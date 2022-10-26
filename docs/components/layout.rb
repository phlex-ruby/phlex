# frozen_string_literal: true

module Components
	class Layout < Phlex::View
		register_element :style

		def initialize(title:)
			@title = title
		end

		def template(&)
			doctype

			html do
				head do
					meta charset: "utf-8"
					meta name: "viewport", content: "width=device-width, initial-scale=1"
					title { @title }
					link href: "/application.css", rel: "stylesheet"
					style { raw Rouge::Theme.find("github").render(scope: ".highlight") }
				end

				body class: "text-stone-700" do
					div class: "flex flex-col" do
						header class: "border-b py-4 px-4 lg:px-10 flex justify-between items-center sticky top-0 left-0 bg-white z-50" do
							div class: "flex flex-row items-center gap-2" do
								label for: "nav-toggle", class: "cursor-pointer lg:hidden" do
									raw '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-8 h-8"> <path fill-rule="evenodd" d="M3 6.75A.75.75 0 013.75 6h16.5a.75.75 0 010 1.5H3.75A.75.75 0 013 6.75zM3 12a.75.75 0 01.75-.75h16.5a.75.75 0 010 1.5H3.75A.75.75 0 013 12zm0 5.25a.75.75 0 01.75-.75h16.5a.75.75 0 010 1.5H3.75a.75.75 0 01-.75-.75z" clip-rule="evenodd" /> </svg>'
								end

								a(href: "/", class: "block") { img src: "/assets/logo.png", width: "100" }
							end

							nav(class: "text-stone-500 font-medium") do
								ul(class: "flex space-x-8") do
									li { a(href: "https://github.com/sponsors/joeldrapper") { "💖️ Sponsor" } }
									li { a(href: "https://github.com/joeldrapper/phlex") { "GitHub" } }
								end
							end
						end

						div do
							div class: "flex flex-row" do
								input type: "checkbox", id: "nav-toggle", class: "flex-0 peer hidden"
								label for: "nav-toggle", class: "top-0 bottom-0 left-0 right-0 bg-gray-900 opacity-0 transition-all peer-checked:fixed peer-checked:z-30 peer-checked:block peer-checked:opacity-50 lg:hidden lg:peer-checked:hidden"
								nav class: "fixed lg:relative w-3/4 border-r-2 border-gray-100 lg:border-0 lg:w-1/4 text-lg lg:text-base h-full z-40 px-10 py-5 -left-full transition-all peer-checked:left-0 lg:left-0 bg-white" do
									h2(class: "text-lg font-semibold pt-5") { "Guide" }

									ul do
										render Nav::Item.new("Introduction", to: Pages::Index, active_page: @_parent)
										render Nav::Item.new("Views", to: Pages::Views, active_page: @_parent)
										render Nav::Item.new("Templates", to: Pages::Templates, active_page: @_parent)
										render Nav::Item.new("Helpers", to: Pages::Helpers, active_page: @_parent)
										render Nav::Item.new("Translations", to: Pages::Translations, active_page: @_parent)
									end

									h2(class: "text-lg font-semibold pt-5") { "Testing" }

									ul do
										render Nav::Item.new("Getting Started", to: Pages::Testing::GettingStarted, active_page: @_parent)
										render Nav::Item.new("RSpec", to: Pages::Testing::RSpec, active_page: @_parent)
										render Nav::Item.new("Minitest", to: Pages::Testing::Minitest, active_page: @_parent)
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

								main class: "w-full lg:w-3/4 px-6 lg:px-20 py-5 border-0 lg:border-l-2 border-gray-100" do
									div(class: "max-w-full lg:max-w-prose prose", &)
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
	end
end
