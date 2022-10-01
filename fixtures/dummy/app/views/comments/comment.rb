# frozen_string_literal: true

module Views
	module Comments
		class Comment < Phlex::View
			def initialize(name:, body:)
				@name = name
				@body = body
			end

			def template(&block)
				div {
					span @name
					span @body

					yield_content(&block)

					render(::ReactionComponent.new(emoji: "hamburger")) do
						p "Emoji reaction for a comment from #{@name} with body #{@body}"
					end
				}
			end
		end
	end
end
