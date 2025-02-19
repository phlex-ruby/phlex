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

	erb :some_part, <<~ERB
		<h2>Some Part</h2>
	ERB

	def greeting
		p { "How do you do?" }
	end

	def card
		some_part
		article do
			yield
		end
	end
end

test do
	output = Example.call

	assert_equivalent_html output, <<~HTML
		<h2>Some Part</h2>
		<article>
			<h1>Hello Joel</h1>
			<p>How do you do?</p>
		</article>
	HTML
end
