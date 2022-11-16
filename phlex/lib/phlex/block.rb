# frozen_string_literal: true

module Phlex
	class Block
		include Callable

		def initialize(context, &block)
			@context = context
			@block = block
		end

		def call(*args, **kwargs)
			@context.instance_exec(*args, **kwargs, &@block)
		end
	end
end
