# frozen_string_literal: true

# An extremely fast in-memory cache store that evicts keys on a first-in-first-out basis.
#: [K, V]
class Phlex::FIFOCacheStore
	def initialize(max_bytesize: 2 ** 20)
		@fifo = Phlex::FIFO.new(
			max_bytesize:,
			max_value_bytesize: max_bytesize
		)
	end

	# (K) { () -> V } -> V
	def fetch(key)
		fifo = @fifo
		key = map_key(key)

		if (result = fifo[key])
			JSON.parse(result)
		else
			result = yield

			fifo[key] = JSON.fast_generate(result)

			result
		end
	end

	#: () -> void
	def clear
		@fifo.clear
	end

	private

	#: (untyped) -> Array | Hash | String | Symbol | Integer | Float | Time | true | false | nil
	def map_key(value)
		case value
		when Array
			value.map { |it| map_key(it) }
		when Hash
			value.to_h { |k, v| [map_key(k), map_key(v)].freeze }
		when String, Symbol, Integer, Float, Time, true, false, nil
			value
		else
			if value.respond_to?(:cache_key_with_version)
				map_key(value.cache_key_with_version)
			elsif value.respond_to?(:cache_key)
				map_key(value.cache_key)
			else
				raise ArgumentError.new("Invalid cache key: #{value.class}")
			end
		end
	end
end
