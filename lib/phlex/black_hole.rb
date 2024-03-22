# frozen_string_literal: true

# @api private
module Phlex::BlackHole
	extend self

	def <<(anything)
		self
	end

	def bytesize
		0
	end

	def dup
		self
	end

	def clear
		self
	end
end
