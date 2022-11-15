# frozen_string_literal: true

module Pages
	module Testing
		class Nokogiri < ApplicationPage
			def template
				render Layout.new(title: "Testing with Nokogiri") do
					render Markdown.new(<<~MD)
						# Testing with Nokogiri

						Phlex includes test helpers for working with rendered views as [Nokogiri](https://nokogiri.org) documents and fragments.

						Nokogiri is not a dependency of Phlex, so you’ll need to install that separately to use this helper.

						## Documents

						If your view represents a whole HTML document, you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::DocumentHelper` module to render your view as `Nokogiri::Document` using the `render` method.
					MD

					render Example.new do |e|
						e.tab "test.rb", <<~RUBY
							require "phlex/testing/nokogiri"

							class TestExample < Minitest::Test
								include Phlex::Testing::Nokogiri::DocumentHelper

								def test_example
									output = render Example.new
									assert_equal "Hello Joel", output.css("h1").text
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

					render Markdown.new(<<~MD)
						## Fragments

						If your view represents a fragment (partial), you can require `phlex/testing/nokogiri` and include the `Phlex::Testing::Nokogiri::FragmentHelper` module to render your view as `Nokogiri::Fragment` with the `render` method.
					MD

					render Example.new do |e|
						e.tab "test.rb", <<~RUBY
							require "phlex/testing/nokogiri"

							class TestExample < Minitest::Test
								include Phlex::Testing::Nokogiri::FragmentHelper

								def test_example
									output = render Example.new("Joel")
									assert_equal "Hello Joel", output.css("h1").text
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
