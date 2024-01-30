# frozen_string_literal: true

module Phlex
	class SVG < SGML
		autoload :StandardElements, "phlex/svg/standard_elements"

		include StandardElements

		# This should be extended after all method definitions
		extend ElementClobberingGuard
	end
end
