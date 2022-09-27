# frozen_string_literal: true

module Pages
	class Templates < ApplicationPage
		def template
			render Layout.new(title: "Templates in Phlex") do
				render Markdown.new(<<~MD)
					# Templates

					Rather than use another langauge like ERB, HAML or Slim, Phlex provides a Ruby DSL for defining HTML templates.

					You can create a view class by subclassing `Phlex::View` and defining a method called `template`. Within the `template` method, you can compose HTML markup by calling the name of any [HTML element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element).

					The first argument to an HTML element method is the _text content_ for that element. For example, here’s a view with an `<h1>` element that says “Hello World!”
				MD

				render Example.new do |e|
					e.tab "heading.rb", <<~RUBY
						class Heading < Phlex::View
							def template
								h1 "Hello World!"
							end
						end
					RUBY

					e.execute "Heading.new.call"
				end

				render Markdown.new(<<~MD)
					The text content is always HTML-escaped, so it’s safe to use with user input.

					## Attributes

					You can add attributes to HTML elements by passing keyword arguments to the tag method. Underscores (`_`) in attribute names are automatically converted to dashes (`-`).
				MD

				render Example.new do |e|
					e.tab "heading.rb", <<~RUBY
						class Heading < Phlex::View
							def template
								h1 "Hello World!",
									class: "text-xl font-bold",
									aria_details: "details"
							end
						end
					RUBY

					e.execute "Heading.new.call"
				end

				render Markdown.new(<<~MD)
					You can also use *boolean* attributes. When set to `true`, the attribute will be rendered without a value, when _falsy_, the attribute isn’t rendered at all.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								input type: "radio", name: "channel", id: "1", checked: true
								input type: "radio", name: "channel", id: "2", checked: false
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					## Nesting

					Pass a block to an element method to nest other elements inside it.
				MD

				render Example.new do |e|
					e.tab "nav.rb", <<~RUBY
						class Nav < Phlex::View
							def template
								nav do
									ul do
										li { a "Home", href: "/" }
										li { a "About", href: "/about" }
										li { a "Contact", href: "/contact" }
									end
								end
							end
						end
					RUBY

					e.execute "Nav.new.call"
				end

				render Markdown.new(<<~MD)
					## Stand-alone text

					You can also output text without wrapping it in an element by using the `text` method. All text content is HTML-escaped, so it’s safe to use with user input.
				MD

				render Example.new do |e|
					e.tab "heading.rb", <<~RUBY
						class Heading < Phlex::View
							def template
								h1 { strong "Hello "; text "World!" }
							end
						end
					RUBY

					e.execute "Heading.new.call"
				end

				render Markdown.new(<<~MD)
					## Whitespace

					While the examples on this page have been formatted for readability, there is usually no whitespace between HTML tags. If you need to add some whitespace, you can use the `whitespace` method. This is useful for adding space between _inline_ elements to allow them to wrap.
				MD

				render Example.new do |e|
					e.tab "links.rb", <<~RUBY
						class Links < Phlex::View
							def template
								a "Home", href: "/"
								whitespace
								a "About", href: "/about"
								whitespace
								a "Contact", href: "/contact"
							end
						end
					RUBY

					e.execute "Links.new.call"
				end

				render Markdown.new(<<~MD)
					## Tokens and classes

					The `tokens` method helps you define conditional HTML attribute tokens (such as CSS classes).

					The `tokens` method accepts a splat of tokens that should always be output, and accepts keyword arguments for conditional tokens.

					The keyword arguments allow you to specify under which conditions certain tokens are applicable. The keyword argument keys are the conditions and the values are the tokens. Conditions can be Procs or Symbols that map to a relevant method. The `:active?` Symbol, for example, maps to the `active?` instance method.

					Here we have a `Link` view that produces an `<a>` tag with the CSS class `nav-item`. And if the link is _active_, we also apply the CSS class `nav-item-active`.
				MD

				render Example.new do |e|
					e.tab "link.rb", <<~RUBY
						class Link < Phlex::View
							def initialize(text, to:, active:)
								@text = text
								@to = to
								@active = active
							end

							def template
								a @text, href: @to, class: tokens("nav-item",
									active?: "nav-item-active")
							end

							private

							def active? = @active
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
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
					You can also use the `classes` helper method to create a token list of classes. Since this method returns a hash (e.g. `{ class: "your CSS classes here" }`), you can destructure it into a `class:` keyword argument using the `**` prefix operator.
				MD

				render Example.new do |e|
					e.tab "link.rb", <<~RUBY
						class Link < Phlex::View
							def initialize(text, to:, active:)
								@text = text
								@to = to
								@active = active
							end

							def template
								a @text, href: @to, **classes("nav-item",
									active?: "nav-item-active")
							end

							private

							def active? = @active
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
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
					## The template element

					Because the `template` method is used to define the view template itself, you need to use the method `template_tag` if you want to to render an HTML `<template>` tag.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								template_tag do
									img src: "hidden.jpg", alt: "A hidden image."
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
