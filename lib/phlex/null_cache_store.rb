# frozen_string_literal: true

module Phlex::NullCacheStore
	extend self

	def fetch(key)
		yield
	end
end
