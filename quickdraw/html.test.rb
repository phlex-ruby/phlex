# frozen_string_literal: true

test "content type" do
	component = Class.new(Phlex::HTML)
	expect(component.new.content_type) == "text/html"
end
