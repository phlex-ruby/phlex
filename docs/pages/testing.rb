# frozen_string_literal: true

module Pages
	class Testing < ApplicationPage
		def template
			render Layout.new(title: "Testing") do
				render Markdown.new(<<~MD)
					# Testing

					## RSpec

					Add test helpers to your suite:

					```ruby
					# spec/support/phlex.rb
					require "phlex/test_helpers"

					RSpec.configure do |config|
						config.include Phlex::TestHelpers, type: :view
					end
					```

					Remember to require this file in `rails_helper.rb` uncommenting the following line:

					```ruby
					Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
					```

					### Asserting without capybara

					```ruby
					# menu.rb
					class Menu < Phlex::View
						def template
							ul do
								li do
									a(href: "/") { "Home" }
									a(href: "/sign_in") { "Sign In" }
							  end
							end
						end
					end

					# menu_spec.rb
					it "renders Home menu item" do
						result = render_view(Menu.new)

						selector = result.css('ul li a[href="/"]:contains("Home")')
						expect(selector).to be_present
					end
					```

					### Asserting with capybara
					Setup capybara:

					```ruby
					# spec/support/capybara.rb
					require "capybara/rspec"

					RSpec.configure do |config|
						config.include Capybara::RSpecMatchers, type: :view
					end
					```

					You are now able to use capybara matchers:

					```ruby
					# menu_spec.rb
					it "renders Home menu item" do
						result = render_view(Menu.new)

						expect(result).to have_link("Home", href: "/")
					end
					```

					### Passing blocks

					You can pass blocks to `render_view`:

					```ruby
					it "renders items" do
						result = render_view(Nav.new) do |nav|
							nav.item(href: "/products/new") { "New Product" }
							nav.item(href: "/categories/new") { "New Category" }
						end

						expect(result).to have_link("New", href: "/products/new")
					end
					```
				MD
			end
		end
	end
end
