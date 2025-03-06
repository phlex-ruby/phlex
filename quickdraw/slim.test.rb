# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize
		@name = "Joel"
	end

	slim :view_template, <<~SLIM
		- card do
			h1 Hello \#{@name}
			= greeting
	SLIM

	slim :say_bye, <<~SLIM, locals: %(name:)
		h2 Goodbye \#{name}
	SLIM

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
