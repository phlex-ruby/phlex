# frozen_string_literal: true

require "delegate"

module Phlex
	class Buffered < SimpleDelegator
		def initialize(object, buffer:)
			super(object)
			@buffer = buffer
		end

		# Alias output methods to this
		def __output_method__(...)
			output = __getobj__.public_send(__callee__, ...)
			@buffer << output if output.is_a? String
			nil
		end
	end
end
