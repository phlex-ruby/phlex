# frozen_string_literal: true

module Phlex
	class SVG < SGML
		include StandardElements

		def template
			yield
		end

		# This should be extended after all method definitions
		extend ElementClobberingGuard
	end
end
