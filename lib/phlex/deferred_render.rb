# frozen_string_literal: true

module Phlex
	module DeferredRender
		include Experimental

		def template(&block)
			capture(&block) # yield the block and throw away the output
			super() # empty parens ensure we don't pass the block which could be yielded a second time
		end
	end
end
