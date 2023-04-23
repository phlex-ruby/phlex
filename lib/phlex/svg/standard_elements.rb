# frozen_string_literal: true

module Phlex::SVG::StandardElements
	extend Phlex::Elements

	# @!method a(**attributes, &content)
	# 	Outputs an `<a>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/a
	register_element :a, tag: "a"

	# @!method animate(**attributes, &content)
	# 	Outputs an `<animate>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animate
	register_element :animate, tag: "animate"

	# @!method animateMotion(**attributes, &content)
	# 	Outputs an `<animateMotion>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion
	register_element :animateMotion, tag: "animateMotion"

	# @!method animateTransform(**attributes, &content)
	# 	Outputs an `<animateTransform>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform
	register_element :animateTransform, tag: "animateTransform"

	# @!method circle(**attributes, &content)
	# 	Outputs a `<circle>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/circle
	register_element :circle, tag: "circle"

	# @!method clipPath(**attributes, &content)
	# 	Outputs a `<clipPath>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/clipPath
	register_element :clipPath, tag: "clipPath"

	# @!method defs(**attributes, &content)
	# 	Outputs a `<defs>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/defs
	register_element :defs, tag: "defs"

	# @!method desc(**attributes, &content)
	# 	Outputs a `<desc>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/desc
	register_element :desc, tag: "desc"

	# @!method discard(**attributes, &content)
	# 	Outputs a `<discard>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/discard
	register_element :discard, tag: "discard"

	# @!method ellipse(**attributes, &content)
	# 	Outputs an `<ellipse>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/ellipse
	register_element :ellipse, tag: "ellipse"

	# @!method feBlend(**attributes, &content)
	# 	Outputs an `<feBlend>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feBlend
	register_element :feBlend, tag: "feBlend"

	# @!method feColorMatrix(**attributes, &content)
	# 	Outputs an `<feColorMatrix>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix
	register_element :feColorMatrix, tag: "feColorMatrix"

	# @!method feComponentTransfer(**attributes, &content)
	# 	Outputs an `<feComponentTransfer>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer
	register_element :feComponentTransfer, tag: "feComponentTransfer"

	# @!method feComposite(**attributes, &content)
	# 	Outputs an `<feComposite>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feComposite
	register_element :feComposite, tag: "feComposite"

	# @!method feConvolveMatrix(**attributes, &content)
	# 	Outputs an `<feConvolveMatrix>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix
	register_element :feConvolveMatrix, tag: "feConvolveMatrix"

	# @!method feDiffuseLighting(**attributes, &content)
	# 	Outputs an `<feDiffuseLighting>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting
	register_element :feDiffuseLighting, tag: "feDiffuseLighting"

	# @!method feDisplacementMap(**attributes, &content)
	# 	Outputs an `<feDisplacementMap>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap
	register_element :feDisplacementMap, tag: "feDisplacementMap"

	# @!method feDistantLight(**attributes, &content)
	# 	Outputs an `<feDistantLight>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight
	register_element :feDistantLight, tag: "feDistantLight"

	# @!method feDropShadow(**attributes, &content)
	# 	Outputs an `<feDropShadow>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow
	register_element :feDropShadow, tag: "feDropShadow"

	# @!method feFlood(**attributes, &content)
	# 	Outputs an `<feFlood>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFlood
	register_element :feFlood, tag: "feFlood"

	# @!method feFuncA(**attributes, &content)
	# 	Outputs an `<feFuncA>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA
	register_element :feFuncA, tag: "feFuncA"

	# @!method feFuncB(**attributes, &content)
	# 	Outputs an `<feFuncB>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB
	register_element :feFuncB, tag: "feFuncB"

	# @!method feFuncG(**attributes, &content)
	# 	Outputs an `<feFuncG>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG
	register_element :feFuncG, tag: "feFuncG"

	# @!method feFuncR(**attributes, &content)
	# 	Outputs an `<feFuncR>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR
	register_element :feFuncR, tag: "feFuncR"

	# @!method feGaussianBlur(**attributes, &content)
	# 	Outputs an `<feGaussianBlur>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur
	register_element :feGaussianBlur, tag: "feGaussianBlur"

	# @!method feImage(**attributes, &content)
	# 	Outputs an `<feImage>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feImage
	register_element :feImage, tag: "feImage"

	# @!method feMerge(**attributes, &content)
	# 	Outputs an `<feMerge>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMerge
	register_element :feMerge, tag: "feMerge"

	# @!method feMergeNode(**attributes, &content)
	# 	Outputs an `<feMergeNode>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode
	register_element :feMergeNode, tag: "feMergeNode"

	# @!method feMorphology(**attributes, &content)
	# 	Outputs an `<feMorphology>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology
	register_element :feMorphology, tag: "feMorphology"

	# @!method feOffset(**attributes, &content)
	# 	Outputs an `<feOffset>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feOffset
	register_element :feOffset, tag: "feOffset"

	# @!method fePointLight(**attributes, &content)
	# 	Outputs an `<fePointLight>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight
	register_element :fePointLight, tag: "fePointLight"

	# @!method feSpecularLighting(**attributes, &content)
	# 	Outputs an `<feSpecularLighting>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting
	register_element :feSpecularLighting, tag: "feSpecularLighting"

	# @!method feSpotLight(**attributes, &content)
	# 	Outputs an `<feSpotLight>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight
	register_element :feSpotLight, tag: "feSpotLight"

	# @!method feTile(**attributes, &content)
	# 	Outputs an `<feTile>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feTile
	register_element :feTile, tag: "feTile"

	# @!method feTurbulence(**attributes, &content)
	# 	Outputs an `<feTurbulence>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence
	register_element :feTurbulence, tag: "feTurbulence"

	# @!method filter(**attributes, &content)
	# 	Outputs a `<filter>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/filter
	register_element :filter, tag: "filter"

	# @!method foreignObject(**attributes, &content)
	# 	Outputs a `<foreignObject>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject
	register_element :foreignObject, tag: "foreignObject"

	# @!method g(**attributes, &content)
	# 	Outputs a `<g>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/g
	register_element :g, tag: "g"

	# @!method image(**attributes, &content)
	# 	Outputs an `<image>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/image
	register_element :image, tag: "image"

	# @!method line(**attributes, &content)
	# 	Outputs a `<line>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/line
	register_element :line, tag: "line"

	# @!method linearGradient(**attributes, &content)
	# 	Outputs a `<linearGradient>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient
	register_element :linearGradient, tag: "linearGradient"

	# @!method marker(**attributes, &content)
	# 	Outputs a `<marker>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/marker
	register_element :marker, tag: "marker"

	# @!method mask(**attributes, &content)
	# 	Outputs a `<mask>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/mask
	register_element :mask, tag: "mask"

	# @!method metadata(**attributes, &content)
	# 	Outputs a `<metadata>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/metadata
	register_element :metadata, tag: "metadata"

	# @!method mpath(**attributes, &content)
	# 	Outputs an `<mpath>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/mpath
	register_element :mpath, tag: "mpath"

	# @!method path(**attributes, &content)
	# 	Outputs a `<path>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/path
	register_element :path, tag: "path"

	# @!method pattern(**attributes, &content)
	# 	Outputs a `<pattern>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/pattern
	register_element :pattern, tag: "pattern"

	# @!method polygon(**attributes, &content)
	# 	Outputs a `<polygon>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/polygon
	register_element :polygon, tag: "polygon"

	# @!method polyline(**attributes, &content)
	# 	Outputs a `<polyline>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/polyline
	register_element :polyline, tag: "polyline"

	# @!method radialGradient(**attributes, &content)
	# 	Outputs a `<radialGradient>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient
	register_element :radialGradient, tag: "radialGradient"

	# @!method rect(**attributes, &content)
	# 	Outputs a `<rect>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/rect
	register_element :rect, tag: "rect"

	# @!method script(**attributes, &content)
	# 	Outputs a `<script>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/script
	register_element :script, tag: "script"

	# @!method set(**attributes, &content)
	# 	Outputs a `<set>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/set
	register_element :set, tag: "set"

	# @!method stop(**attributes, &content)
	# 	Outputs a `<stop>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/stop
	register_element :stop, tag: "stop"

	# @!method style(**attributes, &content)
	# 	Outputs a `<style>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/style
	register_element :style, tag: "style"

	# @!method svg(**attributes, &content)
	# 	Outputs an `<svg>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/svg
	register_element :svg, tag: "svg"

	# @!method switch(**attributes, &content)
	# 	Outputs a `<switch>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/switch
	register_element :switch, tag: "switch"

	# @!method symbol(**attributes, &content)
	# 	Outputs a `<symbol>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/symbol
	register_element :symbol, tag: "symbol"

	# @!method text(**attributes, &content)
	# 	Outputs a `<text>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/text
	register_element :text, tag: "text"

	# @!method textPath(**attributes, &content)
	# 	Outputs a `<textPath>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/textPath
	register_element :textPath, tag: "textPath"

	# @!method title(**attributes, &content)
	# 	Outputs a `<title>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/title
	register_element :title, tag: "title"

	# @!method tspan(**attributes, &content)
	# 	Outputs a `<tspan>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/tspan
	register_element :tspan, tag: "tspan"

	# @!method use(**attributes, &content)
	# 	Outputs a `<use>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/use
	register_element :use, tag: "use"

	# @!method view(**attributes, &content)
	# 	Outputs a `<view>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/view
	register_element :view, tag: "view"
end
