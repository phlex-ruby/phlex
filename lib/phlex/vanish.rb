# frozen_string_literal: true

# @api private
module Phlex::Vanish
	extend self

	#: (untyped) -> Phlex::Vanish
	def <<(anything)
		self
	end

	#: () -> Integer
	def bytesize
		0
	end

	#: () -> Phlex::Vanish
	def dup
		self
	end

	#: () -> Phlex::Vanish
	def clear
		self
	end
end
