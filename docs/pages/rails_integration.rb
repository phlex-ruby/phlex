# frozen_string_literal: true

module Pages
	class RailsIntegration < ApplicationPage
		def template
			render Layout.new(title: "Ruby on Rails integration") do
				render Markdown.new(<<~MD)
					# Ruby on Rails integration

					## Component generator

					You can generate new components with the `rails g phlex:component` command.

					For example, running `rails g phlex:component Card` will create the following file:
				MD

				render CodeBlock.new(<<~RUBY, syntax: :ruby)
					# app/views/card.rb

					module Views
						class Card < Phlex::Component
							def template
							end
						end
					end
				RUBY
			end
		end
	end
end
