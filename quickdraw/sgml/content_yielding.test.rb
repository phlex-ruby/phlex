# frozen_string_literal: true

class TestClass < Phlex::HTML
	def view_template
		select(name: "test") do
			[].each { |i| option_tag(i, i) }
		end

		input(type: "text", name: "other")
	end
end

test "should render the test class" do
	expect(TestClass.call) == %q(<select name="test"></select><input type="text" name="other">)
end

class OtherTestClass < Phlex::HTML
	def view_template
		ul do
			[].each { |i| li { i } }
		end

		p { "hi there" }
	end
end

test "should render the test class" do
	expect(OtherTestClass.call) == %q(<ul></ul><p>hi there</p>)
end
