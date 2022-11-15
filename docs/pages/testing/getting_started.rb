# frozen_string_literal: true

module Pages
	module Testing
		class GettingStarted < ApplicationPage
			def template
				render Layout.new(title: "Getting Started Testing Phlex Views") do
					render Markdown.new(<<~MD)
						# Getting Started

						The `Phlex::Testing::ViewHelper` module defines `render` allowing you to render Phlex views directly in your tests and make assertions against the output.
					MD

					render Example.new do |e|
						e.tab "test/test_hello.rb", <<~RUBY
							require "phlex/testing/view_helper"

							class TestHello < Minitest::Test
								include Phlex::Testing::ViewHelper

								def test_hello_output_includes_name
									output = render Hello.new("Joel")
									assert_equal "<h1>Hello Joel</h1>", output
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
