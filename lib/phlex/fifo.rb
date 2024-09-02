# frozen_string_literal: true

class Phlex::FIFO
	def initialize(max_bytesize = 2_000, max_value_bytesize = 2_000)
		@hash = {}
		@max_bytesize = max_bytesize
		@max_value_bytesize = max_value_bytesize
		@bytesize = 0
		@mutex = Mutex.new
	end

	attr_reader :bytesize, :max_bytesize

	def expand(bytes)
		@mutex.synchronize do
			@max_bytesize += bytes
		end
	end

	def [](key)
		k, v = @hash[key.hash]
		v if k == key
	end

	def []=(key, value)
		if value.bytesize > @max_value_bytesize
			return value
		end

		hash = key.hash

		@mutex.synchronize do
			@hash[hash] = [key, value]
			@bytesize += value.bytesize

			while @bytesize > @max_bytesize
				k, v = @hash.shift
				@bytesize -= v[1].bytesize
			end
		end
	end

	def size
		@hash.size
	end
end
