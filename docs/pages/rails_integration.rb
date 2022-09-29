# frozen_string_literal: true

module Pages
	class RailsIntegration < ApplicationPage
		def template
			render Layout.new(title: "Ruby on Rails integration") do
				render Markdown.new(<<~MD)
					# Ruby on Rails integration

					## Installation

					To install Phlex into your Rails application, you can run the `bin/rails phlex:install` command.

					## Component generator

					You can generate new views with the `rails g phlex:view` command.

					For example, running `rails g phlex:view Card` will create the following file:
				MD

				render CodeBlock.new(<<~RUBY, syntax: :ruby)
					# app/views/card.rb

					module Views
						class Card < Phlex::View
							def template
							end
						end
					end
				RUBY

				render Markdown.new(<<~MD)
					## Helpers

					You can use the `helpers` proxy to access helpers within a `Phlex::View`.

					For example, you can use the `#t` helper for translations:
				MD

				render CodeBlock.new(<<~RUBY, syntax: :ruby)
					# app/views/hello.rb

					module Views
						class Hello < Phlex::View
						  delegate :t, to: :helpers

							def template
							  h1 do
								  t "hello"
								end
							end
						end
					end
				RUBY
			end
		end
	end
end
