# frozen_string_literal: true

module Phlex
	class Buffered
		def initialize(object, buffer:)
			@object, @buffer = object, buffer
		end

		def method_missing(name, *args, **kwargs, &block)
			output = @object.public_send(name, *args, **kwargs, &block)
			@buffer << output if output.is_a? String
			nil
		end

		def respond_to_missing?(name)
			@object.respond_to?(name)
		end
	end
end
