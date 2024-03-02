# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize
		@buffer = +""
		@capturing = false
	end

	attr_accessor :buffer, :capturing

	def capturing_into(new_buffer)
		original_buffer = @buffer
		original_capturing = @capturing

		begin
			@buffer = new_buffer
			@capturing = true
			yield
		ensure
			@buffer = original_buffer
			@capturing = original_capturing
		end

		new_buffer
	end
end
