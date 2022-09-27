# frozen_string_literal: true

module Views
	class Card < Phlex::View
		def template(&block)
			article class: "drop-shadow p-5 rounded", &block
		end

		def title(text)
			h3 text, class: "font-bold"
		end
	end
end
