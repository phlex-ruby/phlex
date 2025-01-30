# frozen_string_literal: true

class Phlex::NullCacheStore
	def fetch(key)
		yield
	end
end
