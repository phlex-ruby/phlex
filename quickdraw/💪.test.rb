# frozen_string_literal: true

class Example < 💪::HTML
	def view_template
		h1 { "💪" }
	end
end

test "💪" do
	expect(Example.new.call) == %(<h1>💪</h1>)
end
