# frozen_string_literal: true

module Components
	class Title < Phlex::View
		def template(&block)
			h1(class: "text-3xl font-semibold my-5") { raw(&block) }
		end
	end
end
