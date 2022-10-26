# frozen_string_literal: true

module Views
	class Heading < ApplicationView
		def template(&)
			h1(&)
		end
	end
end
