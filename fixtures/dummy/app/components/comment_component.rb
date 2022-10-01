# frozen_string_literal: true

class CommentComponent < ViewComponent::Base
	def initialize(name:, body:)
		@name = name
		@body = body
	end
end
