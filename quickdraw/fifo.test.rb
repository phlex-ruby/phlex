# frozen_string_literal: true

test "expires keys" do
	fifo = Phlex::FIFO.new(3)

	fifo["a"] = "a"
	fifo["b"] = "b"
	fifo["c"] = "c"
	fifo["d"] = "d"

	expect(fifo.size) == 3
end
