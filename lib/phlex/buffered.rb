# frozen_string_literal: true

require "delegate"

module Phlex
	class Buffered < BasicObject
		def initialize(object, buffer:)
			@object = object
			@buffer = buffer
		end

		def respond_to_missing?(...)
			@object.respond_to?(...)
		end

		def method_missing(...)
			@object.public_send(...)
		end

		# Alias output methods to this
		def __output_method__(...)
			output = @object.public_send(__callee__, ...)
			@buffer << output if output.is_a? String
			nil
		end
	end
end
