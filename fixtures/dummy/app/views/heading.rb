# frozen_string_literal: true

module Views
	class Heading < Phlex::View
		def template(&block)
			h1(&block)
		end
	end
end
