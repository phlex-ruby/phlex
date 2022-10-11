# frozen_string_literal: true

module Pages
	class Rails::Migrating < ApplicationPage
		def template
			render Layout.new(title: "Migrating to Phlex in Rails") do
				render Markdown.new <<~MD
					# Migrating an existing Rails app to Phlex

					Whether you currently use ActionView or ViewComponent with ERB, HAML or Slim, you can start using Phlex in your Rails app today without a big rewrite.

					## You can render Phlex views into existing templates

					Phlex views implement the _renderable_ interface for Rails, which means they can be rendered from a controller or another view template — even ViewComponent templates. This means you can gradually migrate specific pages and components to Phlex without having to change anything else.

					## You can render ActionView partials and ViewComponent components in Phlex views

					That's right, the `render` method in Phlex doesn't only work with Phlex views. You can use it to render ActionView partials and ViewComponent components too.

					Say you have an `articles/index.html.erb` template that renders a list of articles using the `articles/_article.html.erb` partial. You can convert the index template to an `Articles::Index` Phlex view while continuing to render the same ActionView partial inside it.

					## Use an ERB → Phlex converter

					The ERB → Phlex converter, [Phlexing](https://www.phlexing.fun), can do the heavy-lifting but it won't help you architect your components / design system. Take your time, converting things piece-by-piece.

					If you're using ViewComponent, you might find you can convert components to Phlex views without even changing any call-sites.

					## Save the layout 'til last

					After everything I said about layouts in the previous section, I'll let you in on a little secret: Phlex actually does support `content_for` in one direction. You can't yield a `content_for` block in Phlex, but you can assign one.

					If you're working on an established Rails app, the layout is probably the last thing you should convert. Just include `Phlex::Rails::Helpers::ContentFor` in your `ApplicationView` and you'll be able to render Phlex views into existing ActionView layouts and assign `content_for` blocks too.
				MD
			end
		end
	end
end
