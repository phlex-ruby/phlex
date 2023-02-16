# frozen_string_literal: true

module Phlex
	class SVG < XML
		include StandardElements

		def template
			yield
		end
	end
end
