# frozen_string_literal: true

test "expires keys" do
	fifo = Phlex::FIFO.new(max_bytesize: 3)

	100.times do |i|
		fifo[i] = "a"
	end

	expect(fifo.size) == 3
end

test "reading a key" do
	fifo = Phlex::FIFO.new(max_bytesize: 3)

	fifo[0] = "a"

	expect(fifo[0]) == "a"
end

test "ignores values that are too large" do
	fifo = Phlex::FIFO.new(max_bytesize: 100, max_value_bytesize: 10)

	fifo[1] = "a" * 10
	fifo[2] = "a" * 11

	expect(fifo.size) == 1
end
