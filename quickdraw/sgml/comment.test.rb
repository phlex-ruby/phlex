# frozen_string_literal: true

def phlex(component = Phlex::HTML, *, **, &)
	component.new(*, **).call do |e|
		e.instance_exec(&)
	end
end

test "text comment" do
	expect(
		phlex {
			comment { "Hello World" }
		},
	) == %(<!-- Hello World -->)
end

test "block comment with markup" do
	expect(
		phlex {
			comment {
				h1 { "Hello World" }
			}
		},
	) == %(<!-- <h1>Hello World</h1> -->)
end
