# frozen_string_literal: true

class Phlex::SVG < Phlex::SGML
	autoload :StandardElements, "phlex/svg/standard_elements"

	include StandardElements

	# This should be extended after all method definitions
	extend Phlex::ElementClobberingGuard

	def content_type
		"image/svg+xml"
	end

	def filename
		nil
	end
end
