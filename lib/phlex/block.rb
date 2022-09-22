# frozen_string_literal: true

module Phlex
	class Block
		def initialize(context, &block)
			@context = context
			@block = block
		end

		def to_proc
			method(:call).to_proc
		end

		def call(*args, **kwargs)
			@context.instance_exec(*args, **kwargs, &@block)
		end
	end
end
