# frozen_string_literal: true

test "content type" do
	component = Class.new(Phlex::HTML)

	assert_equal component.new.content_type, "text/html"
end
