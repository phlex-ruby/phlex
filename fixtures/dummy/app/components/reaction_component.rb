# frozen_string_literal: true

class ReactionComponent < ViewComponent::Base
	def initialize(emoji:)
		@emoji = emoji
	end
end
