# frozen_string_literal: true

module Pages
	module Rails
		class GettingStarted < ApplicationPage
			def template
				render Layout.new(title: "Getting started with Rails") do
					render Markdown.new <<~MD
						# Getting started with Phlex on Rails

						While Phlex can be used in any Ruby project, it's especially great with [Rails](https://rubyonrails.org). But before we get into the details, it's important to understand that Phlex is very different from [ActionView](https://guides.rubyonrails.org/action_view_overview.html) and [ViewComponent](https://viewcomponent.org).

						In Phlex, _layouts_, _pages_ and _components_ (or "partials") are the same thing. Phlex Views are Ruby objects that represent every piece of your app's user interface, from pages and layouts and nav-bars, to headings and buttons and links. They're not templates like ERB files in ActionView / ViewComponent; they are just Ruby objects.

						It might feel a bit weird at first, but you'll soon realise how weird it was writing procedural templates in ERB while every other part of your app was object-oriented Ruby.

						## Setup

						If you haven't installed Phlex already, you'll need to add it to your Gemfile. This is a good place to require `phlex/rails`.

						```ruby
						gem "phlex", require: "phlex/rails"
						```

						Now run `bundle install`. Once that's finished, you'll want to run the setup script: `bin/rails phlex:install`.

						This script will:

						1. update `config/application.rb` to include `/app` in your auto-load paths;
						2. generate `views/application_view.rb`.

						Like `ApplicationRecord`, `ApplicationView` is your base view which all your other views should inherit from.

						## Naming conventions

						We recommend using the Zeitwerk conventions for naming. For example, your Articles index page, would be called `Views::Articles::Index` and live in `app/views/articles/index.rb`.

						## View generator

						You can generate new views with the `rails g phlex:view` command.

						For example, running `rails g phlex:view Articles::Index` will create `app/views/articles/index.rb` with the following:

						```ruby
						module Views
							class Articles::Index < ApplicationView
								def template
								end
							end
						end
						```
					MD
				end
			end
		end
	end
end
