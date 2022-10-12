# frozen_string_literal: true

module Pages
	class Translations < ApplicationPage
		def initialize
			I18n.backend.store_translations(
				"pt-BR", {
					hello: "Olá",
					views: { layouts: { feedback: { welcome_message: { hello: "Olá" } } } }
				}
			)
			I18n.locale = "pt-BR"
		end

		def template
			render Layout.new(title: "Translations") do
				render Markdown.new(<<~MD)
					# Translations

					If your application is using [I18n gem](https://github.com/ruby-i18n/i18n) you are able to use `translate`
					or `t` helper methods by including `Phlex::Translation` module to your view class or including it to your
					main class, eg. `ApplicationView`.
				MD

				render Example.new do |e|
					e.tab "welcome_message.rb", <<~RUBY
						# Your translation file `pt-BR.yml`
						# pt-BR:
						#  hello: "Olá"

						class WelcomeMessage < Phlex::View
							include Phlex::Translation

							def template
								h1 { t("hello") }
							end
						end
					RUBY

					e.execute "WelcomeMessage.new.call"
				end

				render Markdown.new(<<~MD)
					## "Lazy" lookup
					Phlex implements a convenient way to look up the locale inside views. If your view class name is
					`Views::Layouts::Feedback::WelcomeMessage.rb`, you can define translation string following the
					`views.layouts.feedback.welcome_message.hello` structure and access its value using `t(".hello")`.
				MD

				render Example.new do |e|
					e.tab "welcome_message.rb", <<~RUBY
						# Your translation file `pt-BR.yml`
						# pt-BR:
						# 	layouts:
						# 		feedback:
						# 			welcome_message:
						# 				hello: Olá

						# app/views/layouts/feedback/welcome_message.rb
						class WelcomeMessage < Phlex::View
							include Phlex::Translation

							def template
								h1 { t(".hello") }
							end
						end
					RUBY

					e.execute <<~RUBY
						WelcomeMessage.translation_path = 'views.layouts.feedback.welcome_message'
						WelcomeMessage.new.call
					RUBY
				end
			end
		end
	end
end
