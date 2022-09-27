# frozen_string_literal: true

module Pages
	class Views < ApplicationPage
		def template
			render Layout.new(title: "Components in Phlex") do
				render Markdown.new(<<~MD)
					#  Views

					## Yielding content

					Your views can accept content as a block passed to the template method. You can capture the content block and pass it to the `content` method to yield it.
				MD

				render Example.new do |e|
					e.tab "card.rb", <<~RUBY
						class Card < Phlex::View
							def template(&)
								article(class: "drop-shadow rounded p-5") {
									h1 "Amazing content!"
									content(&)
								}
							end
						end
					RUBY

					e.execute "Card.new.call { 'Your content here.\n' }"
				end

				render Markdown.new(<<~MD)
					## Delegating content

					Alternatively, you can pass the content down as an argument to another view or tag.
				MD

				render Example.new do |e|
					e.tab "card.rb", <<~RUBY
						class Card < Phlex::View
							def template(&)
								article(class: "drop-shadow rounded p-5", &)
							end
						end
					RUBY

					e.execute "Card.new.call { 'Your content here.' }"
				end

				render Markdown.new(<<~MD)
					## Nested views

					Components can render other views and optionally pass them content as a block.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render Card.new do
									h1 "Hello"
								end
							end
						end
					RUBY

					e.tab "card.rb", <<~RUBY
						class Card < Phlex::View
							def template(&)
								article(class: "drop-shadow rounded p-5", &)
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					If the block just wraps a string, the string is treated as _text content_.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render(Card.new) { "Hi" }
							end
						end
					RUBY

					e.tab "card.rb", <<~RUBY
						class Card < Phlex::View
							def template(&)
								article(class: "drop-shadow rounded p-5", &)
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					## Component attributes

					Besides content, views can define attributes in an initializer, which can then be rendered in the template.
				MD

				render Example.new do |e|
					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def initialize(name:)
								@name = name
							end

							def template
								h1 "Hello \#{@name}!"
							end
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render Hello.new(name: "Joel")
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					It’s usually a good idea to use instance variables directly rather than creating accessor methods for them. Otherwise it’s easy to run into naming conflicts. For example, your layout view might have the attribute `title`, to render into a `<title>` element in the document head. If you define `attr_accessor :title`, that would overwrite the `title` method for creating `<title>` elements.

					## Calculations with methods

					Views are just Ruby classes, so you can perform calculations on view attributes by defining your own methods.
				MD

				render Example.new do |e|
					e.tab "status.rb", <<~RUBY
						class Status < Phlex::View
							def initialize(status:)
								@status = status
							end

							def template
								span status_emoji
							end

							private

							def status_emoji
								case @status
								when :success
									"✅"
								when :failure
									"❌"
								end
							end
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render Status.new(status: :success)
							end
						end
					RUBY

					e.execute "Example.new.call"
				end
			end
		end
	end
end
