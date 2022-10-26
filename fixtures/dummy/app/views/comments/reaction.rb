# frozen_string_literal: true

module Views
	module Comments
		class Reaction < ApplicationView
			def initialize(emoji:)
				@emoji = emoji
			end

			def template(&)
				p { @emoji }

				yield_content(&)
			end
		end
	end
end
