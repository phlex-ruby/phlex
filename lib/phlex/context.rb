# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize(user_context = {})
		@target = +""
		@capturing = false
		@user_context = user_context
	end

	attr_accessor :target, :capturing, :user_context

	def capturing_into(new_target)
		original_target = @target
		original_capturing = @capturing

		begin
			@target = new_target
			@capturing = true
			yield
		ensure
			@target = original_target
			@capturing = original_capturing
		end

		new_target
	end
end
