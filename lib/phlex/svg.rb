# frozen_string_literal: true

class Phlex::SVG < Phlex::SGML
	autoload :StandardElements, "phlex/svg/standard_elements"

	include StandardElements

	def content_type
		"image/svg+xml"
	end

	def filename
		nil
	end
end
