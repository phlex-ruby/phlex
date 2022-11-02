# frozen_string_literal: true

module Phlex
	module Callable
		def to_proc
			method(:call).to_proc
		end
	end
end
