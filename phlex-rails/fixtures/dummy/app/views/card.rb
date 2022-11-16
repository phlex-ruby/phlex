# frozen_string_literal: true

module Views
	class Card < ApplicationView
		def template(&block)
			article class: "drop-shadow p-5 rounded", &block
		end

		def title(text)
			h3 class: "font-bold" do
				text
			end
		end
	end
end
