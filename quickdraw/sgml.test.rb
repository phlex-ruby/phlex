# frozen_string_literal: true

test "components render with a default blank view_template" do
	component = Class.new(Phlex::HTML)
	assert_equal component.new.call, ""
end

test "can't render a component more than once" do
	component = Class.new(Phlex::HTML)

	instance = component.new
	instance.call

	assert_raises(Phlex::DoubleRenderError) { instance.call }
end
