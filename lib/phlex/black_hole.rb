# frozen_string_literal: true

module Phlex
	module BlackHole
		extend self

		def <<(anything)
			self
		end

		def length
			0
		end
	end
end
