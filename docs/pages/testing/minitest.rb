# frozen_string_literal: true

module Pages
	module Testing
		class Minitest < ApplicationPage
			def template
				render Layout.new(title: "Minitest") do
					render Markdown.new(<<~MD)
						# Minitest

						## Setup

						Require test helpers in your test config file:

						```ruby
						# test/test_helper.rb
						require "phlex/test_helpers"
						```

						If you are using Rails, you can add this to in your `test/test_helper.rb` file:

						```ruby
						ActionView::TestCase.include Phlex::TestHelpers
						```

						If you are not using Rails, you'll just need to include the module in your test class, like this:

						```ruby
						class MenuTest < Minitest::Test
							include Phlex::TestHelpers
						end
						```

						Or create your own test case class:

						```ruby
						class PhlexTestCase < Minitest::Test
							include Phlex::TestHelpers
						end

						class MenuTest < PhlexTestCase
							def some_test
								# ...
							end
						end
						```

						## Asserting without capybara

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

						# menu_test.rb
						class MenuTest < ActionView::TestCase # or Minitest::Test
							def test_it_renders_home_menu
								result = render_view(Menu.new)

								selector = result.css('ul li a[href="/"]:contains("Home")')
								assert_equal selector.empty?, false
							end
						end
						```

						In addition to `css` you can use other Nokogiri finders like `xpath`, `at_css`, `at_xpath`. Read more about Nokogiri here: [https://nokogiri.org/](https://nokogiri.org/).

						## Asserting with capybara (Coming Soon)
						Setup capybara following the documentation: [https://github.com/teamcapybara/capybara#using-capybara-with-minitest](https://github.com/teamcapybara/capybara#using-capybara-with-minitest)

						You are now able to use capybara matchers:

						```ruby
						# menu_spec.rb
						class MenuTest < ActionView::TestCase # or Minitest::Test
							def test_it_renders_home_menu
								render_view(MenuTest)

								assert_link "Home", href: "/"
							end
						end
						```

						You can find more Capybara matchers here: [https://github.com/teamcapybara/capybara](https://github.com/teamcapybara/capybara).
						### Passing blocks

						You can pass blocks to `render_view`:

						```ruby
						class NavTest < ActionView::TestCase # or Minitest::Test
							def test_it_accepts_items
								render_view(Nav.new) do |nav|
									nav.item(href: "/products/new") { "New Product" }
									nav.item(href: "/categories/new") { "New Category" }
								end

								assert_link "New Product", href: "/products/new"
							end
						end
						```
					MD
				end
			end
		end
	end
end
