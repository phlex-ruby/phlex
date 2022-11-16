# frozen_string_literal: true

module Views
	class Heading < ApplicationView
		def template(&block)
			h1(&block)
		end
	end
end
