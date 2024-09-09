# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template
		a(
			onclick: safe("window.history.back()"),
			href: safe("javascript:window.history.back()"),
		)
	end
end

test "safe value" do
	expect(Example.call) == %(<a onclick="window.history.back()" href="javascript:window.history.back()"></a>)
end

class ExampleScript < Phlex::HTML
	def view_template
		script { safe(%(console.log("Hello World");)) }
	end
end

test "element content blocks that return safe values" do
	expect(ExampleScript.call) == %(<script>console.log("Hello World");</script>)
end
