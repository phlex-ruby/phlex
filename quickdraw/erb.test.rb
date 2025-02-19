# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize
		@name = "Joel"
	end

	erb :view_template, <<~ERB
		<% card do %>
			<h1>Hello <%= @name %></h1>
			<%= greeting %>
		<% end %>
	ERB

	erb :say_bye, <<~ERB, locals: %(name:)
		<h2>Goodbye <%= name %></h2>
	ERB

	def greeting
		p { "How do you do?" }
	end

	def card
		article do
			yield
		end
		say_bye(name: "Joel")
	end
end

test do
	output = Example.call

	assert_equivalent_html output, <<~HTML
		<article>
			<h1>Hello Joel</h1>
			<p>How do you do?</p>
		</article>
		<h2>Goodbye Joel</h2>
	HTML
end
