# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize(tag, **attributes)
		@tag = tag
		@attributes = attributes
	end

	def view_template(&)
		tag(@tag, **@attributes, &)
	end
end

Phlex::HTML::VoidElements.__registered_elements__.each do |method_name, (tag)|
	test "<#{tag}> without attributes" do
		output = Example.call(tag.to_sym)

		assert_equal_html output, <<~HTML.strip
			<#{tag}>
		HTML
	end

	test "<#{tag}> with attributes" do
		output = Example.call(tag.to_sym, class: "class", id: "id", disabled: true)

		assert_equal_html output, <<~HTML.strip
			<#{tag} class="class" id="id" disabled>
		HTML
	end

	test "<#{tag}> with content" do
		error = assert_raises Phlex::ArgumentError do
			Example.call(tag.to_sym) do
				"Hello, world!"
			end
		end

		assert_equal error.message, "Void elements cannot have content blocks."
	end
end

Phlex::HTML::StandardElements.__registered_elements__.each do |method_name, (tag)|
	test "<#{tag}> without attributes" do
		output = Example.call(tag.to_sym)

		assert_equal_html output, <<~HTML.strip
			<#{tag}></#{tag}>
		HTML
	end

	test "<#{tag}> with attributes" do
		output = Example.call(tag.to_sym, class: "class", id: "id", disabled: true)

		assert_equal_html output, <<~HTML.strip
			<#{tag} class="class" id="id" disabled></#{tag}>
		HTML
	end

	test "<#{tag}> with content" do
		output = Example.call(tag.to_sym) do
			"Hello, world!"
		end

		assert_equal_html output, <<~HTML.strip
			<#{tag}>Hello, world!</#{tag}>
		HTML
	end

	test "<#{tag}> with content and attributes" do
		output = Example.call(tag.to_sym, class: "class", id: "id", disabled: true) do
			"Hello, world!"
		end

		assert_equal_html output, <<~HTML.strip
			<#{tag} class="class" id="id" disabled>Hello, world!</#{tag}>
		HTML
	end
end

test "with invalid tag name" do
	error = assert_raises Phlex::ArgumentError do
		Example.call(:invalidtag)
	end

	assert_equal error.message, "Invalid HTML tag: invalidtag"
end

test "with invalid tag name input type" do
	error = assert_raises Phlex::ArgumentError do
		Example.call("div")
	end

	assert_equal error.message, "Expected the tag name to be a Symbol."
end

test "with custom tag name" do
	output = Example.call(:custom_tag)

	assert_equal_html output, <<~HTML.strip
		<custom-tag></custom-tag>
	HTML
end
