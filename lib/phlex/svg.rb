# frozen_string_literal: true

module Phlex
	class SVG < SGML
		include StandardElements

		def template
			yield
		end
	end
end
