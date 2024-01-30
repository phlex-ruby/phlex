# frozen_string_literal: true

module Phlex
	class ConcurrentMap
		def initialize
			@mutex = Mutex.new
			@map = {}
		end

		def []=(key, value)
			@mutex.synchronize { @map[key] = value }
		end

		def [](key)
			@map[key]
		end

		def each(&block)
			@map.each(&block)
		end
	end
end
