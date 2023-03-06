# frozen_string_literal: true

module Phlex::BlackHole
	extend self

	def <<(anything)
		self
	end

	def length
		0
	end

	def dup
		self
	end

	def clear
		self
	end
end
