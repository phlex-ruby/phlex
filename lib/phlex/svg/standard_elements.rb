# frozen_string_literal: true

module Phlex::SVG::StandardElements
	extend Phlex::Elements

	# @!method a(**attributes, &content)
	# 	Outputs an <code>a</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/a
	register_element :a, tag: "a"

	# @!method animate(**attributes, &content)
	# 	Outputs an <code>animate</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animate
	register_element :animate, tag: "animate"

	# @!method animateMotion(**attributes, &content)
	# 	Outputs an <code>animateMotion</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion
	register_element :animateMotion, tag: "animateMotion"

	# @!method animateTransform(**attributes, &content)
	# 	Outputs an <code>animateTransform</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform
	register_element :animateTransform, tag: "animateTransform"

	# @!method circle(**attributes, &content)
	# 	Outputs an <code>circle</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/circle
	register_element :circle, tag: "circle"

	# @!method clipPath(**attributes, &content)
	# 	Outputs an <code>clipPath</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/clipPath
	register_element :clipPath, tag: "clipPath"

	# @!method defs(**attributes, &content)
	# 	Outputs an <code>defs</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/defs
	register_element :defs, tag: "defs"

	# @!method desc(**attributes, &content)
	# 	Outputs an <code>desc</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/desc
	register_element :desc, tag: "desc"

	# @!method discard(**attributes, &content)
	# 	Outputs an <code>discard</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/discard
	register_element :discard, tag: "discard"

	# @!method ellipse(**attributes, &content)
	# 	Outputs an <code>ellipse</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/ellipse
	register_element :ellipse, tag: "ellipse"

	# @!method feBlend(**attributes, &content)
	# 	Outputs an <code>feBlend</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feBlend
	register_element :feBlend, tag: "feBlend"

	# @!method feColorMatrix(**attributes, &content)
	# 	Outputs an <code>feColorMatrix</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix
	register_element :feColorMatrix, tag: "feColorMatrix"

	# @!method feComponentTransfer(**attributes, &content)
	# 	Outputs an <code>feComponentTransfer</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer
	register_element :feComponentTransfer, tag: "feComponentTransfer"

	# @!method feComposite(**attributes, &content)
	# 	Outputs an <code>feComposite</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feComposite
	register_element :feComposite, tag: "feComposite"

	# @!method feConvolveMatrix(**attributes, &content)
	# 	Outputs an <code>feConvolveMatrix</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix
	register_element :feConvolveMatrix, tag: "feConvolveMatrix"

	# @!method feDiffuseLighting(**attributes, &content)
	# 	Outputs an <code>feDiffuseLighting</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting
	register_element :feDiffuseLighting, tag: "feDiffuseLighting"

	# @!method feDisplacementMap(**attributes, &content)
	# 	Outputs an <code>feDisplacementMap</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap
	register_element :feDisplacementMap, tag: "feDisplacementMap"

	# @!method feDistantLight(**attributes, &content)
	# 	Outputs an <code>feDistantLight</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight
	register_element :feDistantLight, tag: "feDistantLight"

	# @!method feDropShadow(**attributes, &content)
	# 	Outputs an <code>feDropShadow</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow
	register_element :feDropShadow, tag: "feDropShadow"

	# @!method feFlood(**attributes, &content)
	# 	Outputs an <code>feFlood</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFlood
	register_element :feFlood, tag: "feFlood"

	# @!method feFuncA(**attributes, &content)
	# 	Outputs an <code>feFuncA</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA
	register_element :feFuncA, tag: "feFuncA"

	# @!method feFuncB(**attributes, &content)
	# 	Outputs an <code>feFuncB</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB
	register_element :feFuncB, tag: "feFuncB"

	# @!method feFuncG(**attributes, &content)
	# 	Outputs an <code>feFuncG</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG
	register_element :feFuncG, tag: "feFuncG"

	# @!method feFuncR(**attributes, &content)
	# 	Outputs an <code>feFuncR</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR
	register_element :feFuncR, tag: "feFuncR"

	# @!method feGaussianBlur(**attributes, &content)
	# 	Outputs an <code>feGaussianBlur</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur
	register_element :feGaussianBlur, tag: "feGaussianBlur"

	# @!method feImage(**attributes, &content)
	# 	Outputs an <code>feImage</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feImage
	register_element :feImage, tag: "feImage"

	# @!method feMerge(**attributes, &content)
	# 	Outputs an <code>feMerge</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMerge
	register_element :feMerge, tag: "feMerge"

	# @!method feMergeNode(**attributes, &content)
	# 	Outputs an <code>feMergeNode</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode
	register_element :feMergeNode, tag: "feMergeNode"

	# @!method feMorphology(**attributes, &content)
	# 	Outputs an <code>feMorphology</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology
	register_element :feMorphology, tag: "feMorphology"

	# @!method feOffset(**attributes, &content)
	# 	Outputs an <code>feOffset</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feOffset
	register_element :feOffset, tag: "feOffset"

	# @!method fePointLight(**attributes, &content)
	# 	Outputs an <code>fePointLight</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight
	register_element :fePointLight, tag: "fePointLight"

	# @!method feSpecularLighting(**attributes, &content)
	# 	Outputs an <code>feSpecularLighting</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting
	register_element :feSpecularLighting, tag: "feSpecularLighting"

	# @!method feSpotLight(**attributes, &content)
	# 	Outputs an <code>feSpotLight</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight
	register_element :feSpotLight, tag: "feSpotLight"

	# @!method feTile(**attributes, &content)
	# 	Outputs an <code>feTile</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feTile
	register_element :feTile, tag: "feTile"

	# @!method feTurbulence(**attributes, &content)
	# 	Outputs an <code>feTurbulence</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence
	register_element :feTurbulence, tag: "feTurbulence"

	# @!method filter(**attributes, &content)
	# 	Outputs an <code>filter</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/filter
	register_element :filter, tag: "filter"

	# @!method foreignObject(**attributes, &content)
	# 	Outputs an <code>foreignObject</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject
	register_element :foreignObject, tag: "foreignObject"

	# @!method g(**attributes, &content)
	# 	Outputs an <code>g</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/g
	register_element :g, tag: "g"

	# @!method image(**attributes, &content)
	# 	Outputs an <code>image</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/image
	register_element :image, tag: "image"

	# @!method line(**attributes, &content)
	# 	Outputs an <code>line</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/line
	register_element :line, tag: "line"

	# @!method linearGradient(**attributes, &content)
	# 	Outputs an <code>linearGradient</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient
	register_element :linearGradient, tag: "linearGradient"

	# @!method marker(**attributes, &content)
	# 	Outputs an <code>marker</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/marker
	register_element :marker, tag: "marker"

	# @!method mask(**attributes, &content)
	# 	Outputs an <code>mask</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/mask
	register_element :mask, tag: "mask"

	# @!method metadata(**attributes, &content)
	# 	Outputs an <code>metadata</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/metadata
	register_element :metadata, tag: "metadata"

	# @!method mpath(**attributes, &content)
	# 	Outputs an <code>mpath</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/mpath
	register_element :mpath, tag: "mpath"

	# @!method path(**attributes, &content)
	# 	Outputs an <code>path</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/path
	register_element :path, tag: "path"

	# @!method pattern(**attributes, &content)
	# 	Outputs an <code>pattern</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/pattern
	register_element :pattern, tag: "pattern"

	# @!method polygon(**attributes, &content)
	# 	Outputs an <code>polygon</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/polygon
	register_element :polygon, tag: "polygon"

	# @!method polyline(**attributes, &content)
	# 	Outputs an <code>polyline</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/polyline
	register_element :polyline, tag: "polyline"

	# @!method radialGradient(**attributes, &content)
	# 	Outputs an <code>radialGradient</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient
	register_element :radialGradient, tag: "radialGradient"

	# @!method rect(**attributes, &content)
	# 	Outputs an <code>rect</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/rect
	register_element :rect, tag: "rect"

	# @!method script(**attributes, &content)
	# 	Outputs an <code>script</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/script
	register_element :script, tag: "script"

	# @!method set(**attributes, &content)
	# 	Outputs an <code>set</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/set
	register_element :set, tag: "set"

	# @!method stop(**attributes, &content)
	# 	Outputs an <code>stop</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/stop
	register_element :stop, tag: "stop"

	# @!method style(**attributes, &content)
	# 	Outputs an <code>style</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/style
	register_element :style, tag: "style"

	# @!method svg(**attributes, &content)
	# 	Outputs an <code>svg</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/svg
	register_element :svg, tag: "svg"

	# @!method switch(**attributes, &content)
	# 	Outputs an <code>switch</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/switch
	register_element :switch, tag: "switch"

	# @!method symbol(**attributes, &content)
	# 	Outputs an <code>symbol</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/symbol
	register_element :symbol, tag: "symbol"

	# @!method text(**attributes, &content)
	# 	Outputs an <code>text</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/text
	register_element :text, tag: "text"

	# @!method textPath(**attributes, &content)
	# 	Outputs an <code>textPath</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/textPath
	register_element :textPath, tag: "textPath"

	# @!method title(**attributes, &content)
	# 	Outputs an <code>title</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/title
	register_element :title, tag: "title"

	# @!method tspan(**attributes, &content)
	# 	Outputs an <code>tspan</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/tspan
	register_element :tspan, tag: "tspan"

	# @!method use(**attributes, &content)
	# 	Outputs an <code>use</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/use
	register_element :use, tag: "use"

	# @!method view(**attributes, &content)
	# 	Outputs an <code>view</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/SVG/Element/view
	register_element :view, tag: "view"
end
