# frozen_string_literal: true

module Phlex
	module Overrides
		module Symbol
			module Name
				refine(Symbol) { alias_method :name, :to_s }
			end
		end
	end
end
