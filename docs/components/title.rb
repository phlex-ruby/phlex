# frozen_string_literal: true

module Components
	class Title < Phlex::HTML
		def template(&block)
			h1(class: "text-3xl font-semibold my-5") { unsafe_raw(&block) }
		end
	end
end
