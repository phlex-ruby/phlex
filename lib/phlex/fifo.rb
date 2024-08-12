# frozen_string_literal: true

class Phlex::FIFO
	def initialize(max_size = 1_000_000)
		@hash = {}
		@max_size = max_size
	end

	attr_reader :size, :max_size

	def [](key)
		k, v = @hash[key.hash]
		v if k == key
	end

	def []=(key, value)
		hash = key.hash
		@hash[hash] = [key, value]
		@hash.shift while @hash.length > @max_size
	end
end
