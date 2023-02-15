# frozen_string_literal: true

module Phlex::SVG::VoidElements
	extend Phlex::Elements

	REGISTERED_ELEMENTS = Concurrent::Map.new

	register_void_svg_element :animate, tag: "animate"
	register_void_svg_element :animateMotion, tag: "animateMotion"
	register_void_svg_element :animateTransform, tag: "animateTransform"
	register_void_svg_element :circle, tag: "circle"
	register_void_svg_element :ellipse, tag: "ellipse"
	register_void_svg_element :line, tag: "line"
	register_void_svg_element :path, tag: "path"
	register_void_svg_element :polygon, tag: "polygon"
	register_void_svg_element :polyline, tag: "polyline"
	register_void_svg_element :rect, tag: "rect"
	register_void_svg_element :set, tag: "set"
	register_void_svg_element :stop, tag: "stop"
	register_void_svg_element :use, tag: "use"
	register_void_svg_element :view, tag: "view"
end
