# frozen_string_literal: true

module Pages
	class Views < ApplicationPage
		def template
			render Layout.new(title: "Phlex Views") do
				render Markdown.new(<<~MD)
					#  Views

					Phlex Views are Ruby objects that represent your app's user interface — from pages and layouts and nav-bars, to headings and buttons and links.

					You can create a view class by subclassing `Phlex::View` and defining a `template` instance method.
				MD

				render Example.new do |e|
					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def template
								h1 { "👋 Hello World!" }
							end
						end
					RUBY

					e.execute "Hello.new.call"
				end

				render Markdown.new(<<~MD)
					The `template` method determines what your view will output when its rendered. The above example will output an `<h1>` tag with the content `👋 Hello world!`. Click on the "Output" tab above to see for yourself.

					## Accepting arguments

					You can define an initializer for your views just like any other Ruby class. Let's make our `Hello` view take a `name` as a keyword argument, save it in an instance variable and render that variable in the template.

					We'll render this view with the arguments `name: "Joel"` and see what it produces.
				MD

				render Example.new do |e|
					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def initialize(name:)
								@name = name
							end

							def template
								h1 { "👋 Hello \#{@name}!" }
							end
						end
					RUBY

					e.execute "Hello.new(name: 'Joel').call"
				end

				render Markdown.new(<<~MD)
					## Rendering views

					Views can render other views in their templates using the `render` method. Let's try rendering a couple of instances of this `Hello` view from a new `Example` view and look at the output of the `Example` view.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render Hello.new(name: "Joel")
								render Hello.new(name: "Alexandre")
							end
						end
					RUBY

					e.tab "hello.rb", <<~RUBY
						class Hello < Phlex::View
							def initialize(name:)
								@name = name
							end

							def template
								h1 { "👋 Hello \#{@name}!" }
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					## Passing content blocks

					Views can also yield content blocks, which can be passed in when rendering. Let's make a `Card` component that yields content in an `<article>` element with a `drop-shadow` class on it.
				MD

				render Example.new do |e|
					e.tab "card.rb", <<~RUBY
						class Card < Phlex::View
							def template(&content)
								article(class: "drop-shadow") do
									yield_content(&content)
								end
							end
						end
					RUBY

					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							def template
								render Card.new do
									h1 { "👋 Hello!" }
								end
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					The template in the `Card` view accepts a block argument `&content` and uses the `yield_content` method to yield it in an `<article>` element.

					The `Example` view renders a `Card` and passes it a block with an `<h1>` element.

					Looking at the output of the `Example` view, we can see the `<h1>` element was rendered inside the `<article>` element from the `Card` view.

					## Delegating content blocks

					Since the block of content was the only thing we need in the `<article>` element, we could have just passed the content block to the element instead.

					```ruby
					class Card < Phlex::View
						def template(&content)
							article(class: "drop-shadow", &content)
						end
					end
					```
				MD

				render Markdown.new(<<~MD)
					## Registering custom elements

					You can register custom elements with the `register_element` macro. The custom element will only be available in the view where it is registered and subclasses of that view.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
							register_element :trix_editor

							def template
								trix_editor input: "content", autofocus: true
							end
						end
					RUBY

					e.execute "Example.new.call"
				end

				render Markdown.new(<<~MD)
					## Callbacks

					Prepend the `Phlex::View::Callbacks` module, and if you define `#before_rendering_template` and/or `#after_rendering_template` method in your view, they will be called immediately before and after your template is rendered.
				MD

				render Example.new do |e|
					e.tab "example.rb", <<~RUBY
						class Example < Phlex::View
      				prepend Phlex::View::Callbacks

      				def before_rendering_template
								h1 { "Hello" }
							end

							def template
								h2 { "World" }
							end

              def after_rendering_template
								h3 { "Bye" }
							end
      			end
					RUBY

					e.execute "Example.new.call"
				end
			end
		end
	end
end
