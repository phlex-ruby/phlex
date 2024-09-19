# frozen_string_literal: true

def phlex(component = Phlex::HTML, *, **, &)
	component.new(*, **).call do |e|
		e.instance_exec(&)
	end
end

test "whitespae between" do
	expect(
		phlex {
			div
			whitespace
			div
		},
	) == %(<div></div> <div></div>)
end

test "whitespae around" do
	expect(
		phlex {
			div
			whitespace { div }
			div
		},
	) == %(<div></div> <div></div> <div></div>)
end
