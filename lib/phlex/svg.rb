# frozen_string_literal: true

module Phlex
	class SVG < SGML
		include StandardElements

		# This should be extended after all method definitions
		extend ElementClobberingGuard
	end
end
