# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize(user_context = {})
		@buffer = +""
		@capturing = false
		@user_context = user_context
		@fragment = nil
		@in_target_fragment = false
		@found_target_fragment = false
	end

	attr_accessor :buffer, :capturing, :user_context, :fragment,
		:in_target_fragment, :found_target_fragment

	# Added for backwards compatibility with phlex-rails. We can remove this with 2.0
	def target
		@buffer
	end

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
