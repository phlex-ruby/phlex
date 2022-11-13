# frozen_string_literal: true

module Pages
	module Library
		class Collections < ApplicationPage
			def template
				render Layout.new(title: "Getting started with Rails") do
					render Markdown.new <<~MD
						# Collections

						Phlex comes with an abstract pattern for views that represent collections of resources — lists, grids, tables, etc. Collections have two parts: one part wraps the whole collection, the other part is repeated once for each item in that collection.

						When you include `Phlex::Collection` in a `Phlex::HTML`, the `template` and `initialize` methods are defined for you. You don't need to define these. Instead, you define a `collection_template` and `item_template`.

						## Collection template

						The `collection_template` method should accept a content block which is used to yield the items. We can yield this block or pass it to another element, such as `<ul>`.

						```ruby
						def collection_template(&)
							ul(&)
						end
						```

						## Item template

						From the `item_template` method, you can access a single item with the `@item` instance variable.

						```ruby
						def item_template
							li { @item }
						end
						```

						## Rendering a collection

						Putting it all together, we can create a `List` view that renders each item in an `<li>`, all wrapped up in an outer `<ul>`.

						We can render the list by passing any Enumerable as the `collection` keyword argument. Here, we pass the array `["A", "B", "C"]`.
					MD

					render Example.new do |e|
						e.tab "list.rb", <<~RUBY
							class List < Phlex::HTML
								include Phlex::Collection

								def collection_template(&content)
									ul(&content)
								end

								def item_template
									li { @item }
								end
							end
						RUBY

						e.tab "example.rb", <<~RUBY
							class Example < Phlex::HTML
								def template
									render List.new(
										collection: ["A", "B", "C"]
									)
								end
							end
						RUBY

						e.execute "Example.new.call"
					end

					render Markdown.new <<~MD
						## Rendering a single item

						Sometimes you need to render one item of a collection on its own. This is especially handy if you're using Hotwire to append an item to the end of an existing collection. You can render an individual item without the collection wrapper by passing an `item` keyword argument to the collection view.

						```ruby
						render List.new(item: "A")
						```
					MD
				end
			end
		end
	end
end
