# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize
		@text = "text"
		@html = safe "<div>html</div>"
	end

	erb :view_template, <<~ERB
		<% card do %>
			<h1><%= @text %></h1>
			<%= @html %>
			<%= phlex_snippet %>
		<% end %>
	ERB

	erb :erb_snippet, <<~ERB, locals: %(text:)
		<h2>Goodbye <%= text %></h2>
	ERB

	def phlex_snippet
		p { "How do you do?" }
	end

	def card
		section do
			article do
				yield
			end
			erb_snippet(text: "Joel")
		end
	end
end

test do
	output = Example.call

	assert_equivalent_html output, <<~HTML
		<section>
			<article>
				<h1>text</h1>
				<div>html</div>
				<p>How do you do?</p>
			</article>
			<h2>Goodbye Joel</h2>
		</section>
	HTML
end
