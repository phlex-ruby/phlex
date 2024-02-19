# frozen_string_literal: true

class Phlex::FIFO
	def initialize(max_bytesize)
		@hash = {}
		@mutex = Mutex.new

		@bytesize = 0
		@max_bytesize = max_bytesize
	end

	def [](key)
		@hash[key]
	end

	def []=(key, value)
		@mutex.synchronize do
			old_value = @hash.delete(key)
			@hash[key] = value

			@bytesize += value.bytesize - (old_value ? old_value.bytesize : 0)

			while @bytesize > @max_bytesize
				key, value = @hash.shift
				@bytesize -= value.bytesize
			end
		end
	end
end
