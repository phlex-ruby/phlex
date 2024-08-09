# frozen_string_literal: true

class Phlex::FIFO
	def initialize(max_size)
		@hash = {}
		@mutex = Mutex.new

		@size = 0
		@max_size = max_size
	end

	attr_reader :size, :max_size

	def [](key)
		k, v = @hash[key.hash]
		v if k == key
	end

	def []=(key, value)
		@mutex.synchronize do
			hash = key.hash

			@hash[hash] = [key, value]

			while @hash.length > @max_size
				@hash.delete(@hash.each_key.first)
			end
		end
	end
end
