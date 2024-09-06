# frozen_string_literal: true

test "expires keys" do
	fifo = Phlex::FIFO.new(max_bytesize: 3)

	fifo["a"] = "a"
	fifo["b"] = "b"
	fifo["c"] = "c"

	expect(fifo.size) == 3
end
