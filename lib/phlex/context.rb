# frozen_string_literal: true

class Phlex::Context
	def initialize(buffer = +"")
		@buffer = buffer
		@target = +""
	end

	attr_accessor :target, :buffer

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
