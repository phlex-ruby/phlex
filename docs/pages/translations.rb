# frozen_string_literal: true

module Pages
	class Translations < ApplicationPage
		def initialize
			I18n.backend.store_translations(
				"pt-BR", {
					hello: "Olá",
					views: { feedback: { welcome_message: { hello: "Olá" } } }
				}
			)
			I18n.locale = "pt-BR"
		end

		def template
			render Layout.new(title: "Translations") do
				render Markdown.new(<<~MD)
					# Translations

					Phlex has built-in support for translations with the **[I18n Gem](https://github.com/ruby-i18n/i18n)**.

					Just include `Phlex::Translation` in your view and use the `translate` method to access a translation.
				MD

				render Example.new do |e|
					e.tab "welcome_message.rb", <<~RUBY
						class WelcomeMessage < Phlex::HTML
							include Phlex::Translation

							def template
								h1 { translate("hello") }
							end
						end
					RUBY

					e.tab "pt-PR.yml", <<~YAML, syntax: :yaml
						pt-BR:
						  hello: "Olá"
					YAML

					e.execute "WelcomeMessage.new.call"
				end

				render Markdown.new(<<~MD)
					## Implicit scoopes

					Start your translate key with a `.` to use the name of the view as an implicit scope.
				MD

				render Example.new do |e|
					e.tab "welcome_message.rb", <<~RUBY
						module Views
							module Feedback
								class WelcomeMessage < Phlex::HTML
									include Phlex::Translation

									def template
										h1 { translate(".hello") }
									end
								end
							end
						end
					RUBY

					e.tab "pt-BR.yml", <<~YAML, syntax: :yaml
						pt-BR:
						  views:
						    feedback:
						      welcome_message:
						        hello: Olá
					YAML

					e.execute <<~RUBY
						Views::Feedback::WelcomeMessage.translation_path = 'views.feedback.welcome_message'
						Views::Feedback::WelcomeMessage.new.call
					RUBY
				end
			end
		end
	end
end
