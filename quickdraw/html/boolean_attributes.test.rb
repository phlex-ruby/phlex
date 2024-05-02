# frozen_string_literal: true

class BooleanAttribute < Phlex::HTML
	def view_template
		button(:disabled, type: "button") { "Disabled button" }
	end
end

class BooleanAndStandardAttribute < Phlex::HTML
	def view_template
		button(:disabled, disabled: true, type: "button") { "Disabled button" }
	end
end

test "boolean attributes are supported" do
	expect(BooleanAttribute.call) == "<button type=\"button\" disabled>Disabled button</button>"
end

test "using boolean attributes and standard attributes do not conflict" do
	expect(BooleanAndStandardAttribute.call) == "<button disabled type=\"button\">Disabled button</button>"
end
