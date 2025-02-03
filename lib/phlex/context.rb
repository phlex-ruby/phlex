# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize(user_context: {}, view_context: nil)
		@buffer = +""
		@capturing = false
		@user_context = user_context
		@view_context = view_context
	end

	attr_accessor :buffer, :capturing, :user_context

	attr_reader :view_context

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
