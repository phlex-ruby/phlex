# frozen_string_literal: true

test "user context passed in from the outside" do
	example = Class.new(Phlex::HTML) do
		define_method :view_template do
			h1 { context[:heading] }
		end
	end

	context = { heading: "Hello, World!" }
	assert_equal_html example.new.call(context:), %(<h1>Hello, World!</h1>)
end

test "user context passed down" do
	a = Class.new(Phlex::HTML) do
		define_method :view_template do
			h1 { context[:heading] }
		end
	end

	b = Class.new(Phlex::HTML) do
		define_method :view_template do
			context[:heading] = "Hello, World!"
			render a.new
		end
	end

	assert_equal_html b.new.call, %(<h1>Hello, World!</h1>)
end
