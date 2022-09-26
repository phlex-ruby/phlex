# frozen_string_literal: true

class Comment < ViewComponent::Base
	def initialize(name:, body:)
		@name = name
		@body = body
	end
end
