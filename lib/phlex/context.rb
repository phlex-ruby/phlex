# frozen_string_literal: true

# @api private
class Phlex::Context
	def initialize
		@target = +""
	end

	attr_accessor :target

	def with_target(new_target)
		original_target = @target

		begin
			@target = new_target
			yield
		ensure
			@target = original_target
		end

		new_target
	end
end
