# frozen_string_literal: true

test "with string" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain "Hello, World!"
		end
	end

	expect(component.new.call) == "Hello, World!"
end

test "with symbol" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain :hello_world
		end
	end

	expect(component.new.call) == "hello_world"
end

test "with integer" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain 42
		end
	end

	expect(component.new.call) == "42"
end

test "with float" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain 3.14
		end
	end

	expect(component.new.call) == "3.14"
end

test "with nil" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain nil
		end
	end

	expect(component.new.call) == ""
end

test "with array" do
	component = Class.new(Phlex::HTML) do
		define_method(:view_template) do
			plain [1, 2, 3]
		end
	end

	expect { component.new.call }.to_raise(Phlex::ArgumentError)
end
