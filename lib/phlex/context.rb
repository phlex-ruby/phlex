# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize
		@target = +""
		@capturing = false
	end

	attr_accessor :target, :capturing

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
