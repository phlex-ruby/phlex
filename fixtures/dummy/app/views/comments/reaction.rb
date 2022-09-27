# frozen_string_literal: true

module Views
	module Comments
		class Reaction < Phlex::Component
			def initialize(emoji:)
				@emoji = emoji
			end

			def template(&block)
				p @emoji

				content(&block)
			end
		end
	end
end
