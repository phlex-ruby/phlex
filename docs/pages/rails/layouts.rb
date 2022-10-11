# frozen_string_literal: true

module Pages
	module Rails
		class Layouts < ApplicationPage
			def template
				render Layout.new(title: "Getting started with Rails") do
					render Markdown.new <<~MD
						# Layouts in Rails

						Rails has an implicit layouts feature that automatically wraps views in a layout template, usually `views/layouts/application.html.erb`. When using Phlex, you'll probably want to by-pass this feature completely. Here's why:

						Sometimes you need to pass some argument to the layout, such as a page title that needs to be rendered in a `<title>` tag in the HTML `<head>`. Rails lets you do this from another part of the view using the `content_for` feature, but this pattern precludes defining an explicit interface for your layout through its initializer.

						If layouts are Phlex views, they can be rendered just like any other view and can require that `title` argument from their initializer. The trick is the page view renders its content into the layout view.
					MD

					render Example.new do |e|
						e.tab "layout.rb", <<~RUBY
							module Views
								class Layout < Phlex::View
									def initialize(title:)
										@title = title
									end

									def template(&)
										html do
											head do
												title { @title }
											end

											body(&)
										end
									end
								end
							end
						RUBY

						e.tab "index.rb", <<~RUBY
							module Views
								class Index < Phlex::View
									def template
										render Layout.new(title: "Hello") do
											h1 { "👋" }
										end
									end
								end
							end
						RUBY

						e.execute "Views::Index.new.call"
					end

					render Markdown.new <<~MD
						If you're using a Phlex view as a layout, you'll want to disable layouts from your Rails controller. You can do this by adding `layout false` to your controller. In a new app, you'll probably want to add this to the `ApplicationController`.
					MD
				end
			end
		end
	end
end
