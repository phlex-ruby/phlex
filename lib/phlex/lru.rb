# frozen_string_literal: true

class Phlex::LRU
	def initialize(max_byte_size)
		@hash = {}
		@mutex = Mutex.new

		@size = 0
		@max_byte_size = max_byte_size
	end

	def [](key)
		@mutex.synchronize do
			if (value = @hash[key])
				@hash.delete(key)
				@hash[key] = value
			end
		end
	end

	def []=(key, value)
		@mutex.synchronize do
			old_value = @hash.delete(key)
			@hash[key] = value

			@size += value.bytesize - (old_value ? old_value.bytesize : 0)

			while @size > @max_byte_size
				key, value = @hash.shift
				@size -= value.bytesize
			end
		end
	end

	def delete(key)
		@mutex.synchronize do
			old_value = @hash.delete(key)
			@size -= old_value.bytesize if old_value
		end
	end

	def include?(key)
		@hash.include?(key)
	end

	def fetch(key)
		@mutex.synchronize do
			if (value = @hash[key])
				value
			else
				@hash[key] = yield
			end
		end
	end

	def size
		@hash.size
	end

	def empty?
		@hash.empty?
	end

	def clear
		@mutex.synchronize do
			@hash.clear
		end
	end
end
