# frozen_string_literal: true

class Phlex::FIFO
	def initialize(max_bytesize)
		@hash = {}
		@mutex = Mutex.new

		@bytesize = 0
		@max_bytesize = max_bytesize
	end

	attr_reader :bytesize, :max_bytesize

	def [](key)
		@hash[key]
	end

	def []=(key, value)
		@mutex.synchronize do
			old_value = @hash.delete(key)
			@hash[key] = value

			if old_value
				@bytesize += value.bytesize - old_value.bytesize
			else
				@bytesize += value.bytesize
			end

			while @bytesize > @max_bytesize
				key, value = @hash.shift
				@bytesize -= value.bytesize
			end
		end
	end
end
