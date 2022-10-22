# frozen_string_literal: true

module Pages
	module Testing
		class GettingStarted < ApplicationPage
			def template
				render Layout.new(title: "Getting started") do
					render Markdown.new(<<~MD)
						# Getting Started

						One of the advantages of adopting View::Phlex is the ease of testing isolated snippets of your view. Each
						view can be unit tested against the rendered output, you just need add `nokogiri` to your application dependencies.

						## Nokogiri

						If you are on Ruby on Rails, you can skip this step.

						While Nokogiri is already shipped with Ruby on Rails, you will need add Nokogiri gem to your application test dependencies if
						your application doesn't already have it added.

						Run `bundle add nokogiri --group test`, then require nokogiri in at top of your test config file (`spec/spec_helper.rb` for RSpec users and `test/test_helper.rb` for Minitest users).

						```ruby
						require "nokogiri"
						```

						You are now ready to start testing your phlex views. Check out the RSpec or Minitest pages to learn more.

						## Capybara

						This step is optional, but you can take advantage of capybara matchers while testing your phlex views.
						You will need to setup capybara in your test suite, you can read here how to do it: ([https://github.com/teamcapybara/capybara](https://github.com/teamcapybara/capybara)).
					MD
				end
			end
		end
	end
end
