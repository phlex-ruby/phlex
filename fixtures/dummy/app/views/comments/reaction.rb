# frozen_string_literal: true

module Views
	module Comments
		class Reaction < Phlex::View
			def initialize(emoji:)
				@emoji = emoji
			end

			def template(&block)
				p @emoji

				yield_content(&block)
			end
		end
	end
end
