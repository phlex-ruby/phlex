# frozen_string_literal: true

module Phlex::SVG::StandardElements
	extend Phlex::Elements

	REGISTERED_ELEMENTS = Concurrent::Map.new

	register_element :svg, tag: "svg"
end
