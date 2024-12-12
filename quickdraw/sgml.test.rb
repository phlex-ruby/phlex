# frozen_string_literal: true

test "components render with a default blank view_template" do
	component = Class.new(Phlex::HTML) do
		def view_template
		end
	end

	expect(component.new.call) == ""
end

test "components with old `template` method render warning" do
	component = Class.new(Phlex::HTML) do
		def template
			span "old template"
		end
	end

	expect(component.new.call) == Phlex::Escape.html_escape(
		%(Phlex Warning: Your `#{component.name}` class doesn't define a `view_template` method. If you are upgrading to Phlex 2.x make sure to rename your `template` method to `view_template`. See: https://beta.phlex.fun/guides/v2-upgrade.html)
	)
end

test "components with no `view_template` method render warning" do
	component = Class.new(Phlex::HTML)

	expect(component.new.call) == Phlex::Escape.html_escape(
		%(Phlex Warning: Your `#{component.name}` class doesn't define a `view_template` method. If you are upgrading to Phlex 2.x make sure to rename your `template` method to `view_template`. See: https://beta.phlex.fun/guides/v2-upgrade.html)
	)
end

test "can't render a component more than once" do
	component = Class.new(Phlex::HTML)

	instance = component.new
	instance.call
	expect { instance.call }.to_raise(Phlex::DoubleRenderError)
end
