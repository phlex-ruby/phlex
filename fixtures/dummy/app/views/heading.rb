# frozen_string_literal: true

module Views
	class Heading < Phlex::Component
		def template(&block)
			h1(&block)
		end
	end
end
