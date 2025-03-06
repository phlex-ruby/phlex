# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize
		@name = "Joel"
	end

	haml :view_template, <<~HAML
		- card do
			%h1 Hello \#{@name}
			= greeting
	HAML

	haml :say_bye, <<~HAML, locals: %(name:)
		%h2 Goodbye \#{name}
	HAML

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
