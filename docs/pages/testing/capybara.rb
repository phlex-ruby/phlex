# frozen_string_literal: true

require "minitest"

module Pages
	module Testing
		class Capybara < ApplicationPage
			def template
				render Layout.new(title: "Testing with Capybara") do
					render Markdown.new(<<~MD)
						# Testing with Capybara

						Require `phlex/testing/capybara` and include `Phlex::Testing::Capybara::ViewHelper` to use [Capybara](http://teamcapybara.github.io/capybara/) matchers.

						The `render` method will return a `Capybara::Node::Simple` and set the `page` attribute to the result.
					MD

					render Example.new do |e|
						e.tab "test.rb", <<~RUBY
							require "phlex/testing/capybara"

							class TestExample < Minitest::Test
								include Phlex::Testing::Capybara::ViewHelper

								def test_example
									render Example.new("Joel")
									assert_select "h1", text: "Hello Joel"
								end
							end
						RUBY

						e.tab "hello.rb", <<~RUBY
							class Hello < Phlex::HTML
								def initialize(name)
									@name = name
								end

								def template
									h1 { "Hello \#{@name}" }
								end
							end
						RUBY
					end
				end
			end
		end
	end
end
