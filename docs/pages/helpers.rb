# frozen_string_literal: true

module Pages
	class Helpers < ApplicationPage
		def template
			render Layout.new(title: "Helpers") do
				render Markdown.new(<<~MD)
					# Helpers

					## Conditional tokens and classes

					The `tokens` method helps you define conditional HTML attribute tokens (such as CSS classes). It accepts a splat of tokens that should always be output as well as optional keyword arguments for conditional tokens.

					The keyword arguments allow you to specify under which conditions certain tokens are applicable. The keys are the conditions and the values are the tokens. Conditions can be Procs which are evaluated, or Symbols that map to an instance method. The `:active?` Symbol, for example, maps to the `active?` instance method.

					Here we have a `Link` view that produces an `<a>` tag with the CSS class `nav-item`. If the link is _active_, we also apply the CSS class `nav-item-active`.
				MD

				render Example.new do |e|
					e.tab "link.rb", <<~RUBY
						class Link < Phlex::HTML
							def initialize(text, to:, active:)
								@text = text
								@to = to
								@active = active
							end

							def template
								a(href: @to, class: tokens("nav-item",
									active?: "nav-item-active")) { @text }
							end

							private

							def active? = @active
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::HTML
							def template
								nav do
									ul do
										li { render Link.new("Home", to: "/", active: true) }
										li { render Link.new("About", to: "/about", active: false) }
									end
								end
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					You can also use the `classes` helper method to create a token list of classes. Since this method returns a hash, e.g. `{ class: "your CSS classes here" }`, you can destructure it into a `class:` keyword argument using the `**` prefix operator.
				MD

				render Example.new do |e|
					e.tab "link.rb", <<~RUBY
						class Link < Phlex::HTML
							def initialize(text, to:, active:)
								@text = text
								@to = to
								@active = active
							end

							def template
								a(href: @to, **classes("nav-item",
									active?: "nav-item-active")) { @text }
							end

							private

							def active? = @active
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::HTML
							def template
								nav do
									ul do
										li { render Link.new("Home", to: "/", active: true) }
										li { render Link.new("About", to: "/about", active: false) }
									end
								end
							end
						end
					RUBY

					e.execute "Example.new.call"
				end
			end
		end
	end
end
