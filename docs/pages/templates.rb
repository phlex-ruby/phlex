# frozen_string_literal: true

module Pages
	class Templates < ApplicationPage
		def template
			render Layout.new(title: "Templates in Phlex") do
				render Markdown.new(<<~MD)
					# Working with templates

					In Phlex, templates are just methods that call other methods that add things to the output buffer. When you call the method `h1`, an `<h1>` tag is buffered for output.

					## Tag attributes

					You can add attributes to HTML tags by passing keyword arguments to the tag methods.
				MD

				render Example.new do |e|
					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def template
								h1(class: "text-xl font-bold") { "👋 Hello World!" }
							end
						end
					RUBY

					e.execute "Hello.new.call"
				end

				render Markdown.new(<<~MD)
					## Hash attributes

					If you pass a `Hash` as an attribute value, the hash will be flattened with a dash between each section.
				MD

				render Example.new do |e|
					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def template
								div(data: { controller: "hello" }) do
									# ...
								end
							end
						end
					RUBY

					e.execute "Hello.new.call"
				end

				render Markdown.new(<<~MD)
					## Boolean attributes

					When `true`, the attribute will be rendered without a value; when _falsy_, the attribute isn’t rendered at all. You can still use the strings `"true"` and `"false"` as values for non-boolean attributes.
				MD

				render Example.new do |e|
					e.tab "channel_controls.rb", <<~RUBY
						class ChannelControls < Phlex::View
							def template
								input(
									value: "1",
									name: "channel",
									type: "radio",
									checked: true
								)

								input(
									value: "2",
									name: "channel",
									type: "radio",
									checked: false
								)
							end
						end
					RUBY

					e.execute "ChannelControls.new.call"
				end

				render Markdown.new(<<~MD)
					## Processing Attributes

					Sometimes you may want to process, modify, or simply be able to read the attributes that tags are given. For example, you may want to assign an `id` attribute to every tag, or even use the `tokens` helper to automatically tokenize the `class` attribute.

					Simply define a `process_attributes` method in your view. This method will be called on each tag, with the attributes as keyword arguments, and should return a Hash of the attributes.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								h1(class: 'title') { "Hello" }
							end

							def process_attributes(**attributes)
								attributes.tap do |attrs|
									attrs[:id] = SecureRandom.uuid
								end
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					## The template tag

					Because the `template` method is used to define the view template itself, you'll need to use the method `template_tag` if you want to to render an HTML `<template>` tag.
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

				render Markdown.new(<<~MD)
					## Stand-alone text

					You can output text content without wrapping it in an element by using the `text` helper method.
				MD

				render Example.new do |e|
					e.tab "heading.rb", <<~RUBY
						class Heading < Phlex::View
							def template
								h1 do
									strong { "Hello " }
									text "World!"
								end
							end
						end
					RUBY

					e.execute "Heading.new.call"
				end

				render Markdown.new(<<~MD)
					## Whitespace

					The example output on this site is formatted for readability, but there is usually no whitespace between HTML tags in the output. If you need to add some whitespace, you can use the `whitespace` helper. This is useful for adding space between _inline_ elements to allow them to wrap.
				MD

				render Example.new do |e|
					e.tab "links.rb", <<~RUBY
						class Links < Phlex::View
							def template
								a(href: "/") { "Home" }
								whitespace
								a(href: "/about") { "About" }
								whitespace
								a(href: "/contact") { "Contact" }
							end
						end
					RUBY

					e.execute "Links.new.call"
				end
			end
		end
	end
end
