# frozen_string_literal: true

def render(&)
	Phlex::HTML.new.call do |e|
		e.instance_exec(&)
	end
end

test "whitespae between" do
	expect(
		render do
			div
			whitespace
			div
		end,
	) == %(<div></div> <div></div>)
end

test "whitespae around" do
	expect(
		render do
			div
			whitespace do
				div
			end
			div
		end,
	) == %(<div></div> <div></div> <div></div>)
end
