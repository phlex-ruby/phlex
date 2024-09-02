# frozen_string_literal: true

test "default view_template" do
	component = Class.new(Phlex::HTML)
	expect(component.new.call) == ""
end

test "content type" do
	component = Class.new(Phlex::HTML)
	expect(component.new.content_type) == "text/html"
end
