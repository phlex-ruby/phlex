# frozen_string_literal: true

module Phlex
	module DeferredRender
		def around_content(&block)
			capture(&block)
			super() # empty parens stop passing the block
		end
	end
end
