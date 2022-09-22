# frozen_string_literal: true

module Components
	class Title < Phlex::Component
		def template(&block)
			h1(class: "text-2xl font-bold my-5", &block)
		end
	end
end
