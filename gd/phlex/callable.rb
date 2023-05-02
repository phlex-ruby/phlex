# frozen_string_literal: true

class Example
	include Phlex::Callable

	def call
		"Hello, world!"
	end
end

def example
	Example.new
end

test "to_proc" do
	expect(example.to_proc).to_be_a Proc
	expect(example.to_proc.call) == "Hello, world!"
end
