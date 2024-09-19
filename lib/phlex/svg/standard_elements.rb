# frozen_string_literal: true

module Phlex::SVG::StandardElements
	extend Phlex::SGML::Elements

	# Outputs an `<a>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/a
	def a(**attributes, &content) = nil
	register_element :a

	# Outputs an `<animate>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/animate
	def animate(**attributes, &content) = nil
	register_element :animate

	# Outputs an `<animateMotion>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion
	def animateMotion(**attributes, &content) = nil
	register_element :animateMotion

	# Outputs an `<animateTransform>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform
	def animateTransform(**attributes, &content) = nil
	register_element :animateTransform

	# Outputs a `<circle>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/circle
	def circle(**attributes, &content) = nil
	register_element :circle

	# Outputs a `<clipPath>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/clipPath
	def clipPath(**attributes, &content) = nil
	register_element :clipPath

	# Outputs a `<defs>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/defs
	def defs(**attributes, &content) = nil
	register_element :defs

	# Outputs a `<desc>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/desc
	def desc(**attributes, &content) = nil
	register_element :desc

	# Outputs a `<discard>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/discard
	def discard(**attributes, &content) = nil
	register_element :discard

	# Outputs an `<ellipse>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/ellipse
	def ellipse(**attributes, &content) = nil
	register_element :ellipse

	# Outputs an `<feBlend>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feBlend
	def feBlend(**attributes, &content) = nil
	register_element :feBlend

	# Outputs an `<feColorMatrix>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix
	def feColorMatrix(**attributes, &content) = nil
	register_element :feColorMatrix

	# Outputs an `<feComponentTransfer>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer
	def feComponentTransfer(**attributes, &content) = nil
	register_element :feComponentTransfer

	# Outputs an `<feComposite>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feComposite
	def feComposite(**attributes, &content) = nil
	register_element :feComposite

	# Outputs an `<feConvolveMatrix>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix
	def feConvolveMatrix(**attributes, &content) = nil
	register_element :feConvolveMatrix

	# Outputs an `<feDiffuseLighting>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting
	def feDiffuseLighting(**attributes, &content) = nil
	register_element :feDiffuseLighting

	# Outputs an `<feDisplacementMap>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap
	def feDisplacementMap(**attributes, &content) = nil
	register_element :feDisplacementMap

	# Outputs an `<feDistantLight>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight
	def feDistantLight(**attributes, &content) = nil
	register_element :feDistantLight

	# Outputs an `<feDropShadow>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow
	def feDropShadow(**attributes, &content) = nil
	register_element :feDropShadow

	# Outputs an `<feFlood>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFlood
	def feFlood(**attributes, &content) = nil
	register_element :feFlood

	# Outputs an `<feFuncA>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA
	def feFuncA(**attributes, &content) = nil
	register_element :feFuncA

	# Outputs an `<feFuncB>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB
	def feFuncB(**attributes, &content) = nil
	register_element :feFuncB

	# Outputs an `<feFuncG>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG
	def feFuncG(**attributes, &content) = nil
	register_element :feFuncG

	# Outputs an `<feFuncR>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR
	def feFuncR(**attributes, &content) = nil
	register_element :feFuncR

	# Outputs an `<feGaussianBlur>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur
	def feGaussianBlur(**attributes, &content) = nil
	register_element :feGaussianBlur

	# Outputs an `<feImage>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feImage
	def feImage(**attributes, &content) = nil
	register_element :feImage

	# Outputs an `<feMerge>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMerge
	def feMerge(**attributes, &content) = nil
	register_element :feMerge

	# Outputs an `<feMergeNode>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode
	def feMergeNode(**attributes, &content) = nil
	register_element :feMergeNode

	# Outputs an `<feMorphology>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology
	def feMorphology(**attributes, &content) = nil
	register_element :feMorphology

	# Outputs an `<feOffset>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feOffset
	def feOffset(**attributes, &content) = nil
	register_element :feOffset

	# Outputs an `<fePointLight>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight
	def fePointLight(**attributes, &content) = nil
	register_element :fePointLight

	# Outputs an `<feSpecularLighting>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting
	def feSpecularLighting(**attributes, &content) = nil
	register_element :feSpecularLighting

	# Outputs an `<feSpotLight>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight
	def feSpotLight(**attributes, &content) = nil
	register_element :feSpotLight

	# Outputs an `<feTile>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feTile
	def feTile(**attributes, &content) = nil
	register_element :feTile

	# Outputs an `<feTurbulence>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence
	def feTurbulence(**attributes, &content) = nil
	register_element :feTurbulence

	# Outputs a `<filter>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/filter
	def filter(**attributes, &content) = nil
	register_element :filter

	# Outputs a `<foreignObject>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject
	def foreignObject(**attributes, &content) = nil
	register_element :foreignObject

	# Outputs a `<g>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/g
	def g(**attributes, &content) = nil
	register_element :g

	# Outputs an `<image>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/image
	def image(**attributes, &content) = nil
	register_element :image

	# Outputs a `<line>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/line
	def line(**attributes, &content) = nil
	register_element :line

	# Outputs a `<linearGradient>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient
	def linearGradient(**attributes, &content) = nil
	register_element :linearGradient

	# Outputs a `<marker>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/marker
	def marker(**attributes, &content) = nil
	register_element :marker

	# Outputs a `<mask>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/mask
	def mask(**attributes, &content) = nil
	register_element :mask

	# Outputs a `<metadata>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/metadata
	def metadata(**attributes, &content) = nil
	register_element :metadata

	# Outputs an `<mpath>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/mpath
	def mpath(**attributes, &content) = nil
	register_element :mpath

	# Outputs a `<path>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/path
	def path(**attributes, &content) = nil
	register_element :path

	# Outputs a `<pattern>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/pattern
	def pattern(**attributes, &content) = nil
	register_element :pattern

	# Outputs a `<polygon>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/polygon
	def polygon(**attributes, &content) = nil
	register_element :polygon

	# Outputs a `<polyline>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/polyline
	def polyline(**attributes, &content) = nil
	register_element :polyline

	# Outputs a `<radialGradient>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient
	def radialGradient(**attributes, &content) = nil
	register_element :radialGradient

	# Outputs a `<rect>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/rect
	def rect(**attributes, &content) = nil
	register_element :rect

	# Outputs a `<script>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/script
	def script(**attributes, &content) = nil
	register_element :script

	# Outputs a `<set>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/set
	def set(**attributes, &content) = nil
	register_element :set

	# Outputs a `<stop>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/stop
	def stop(**attributes, &content) = nil
	register_element :stop

	# Outputs a `<style>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/style
	def style(**attributes, &content) = nil
	register_element :style

	# Outputs an `<svg>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/svg
	def svg(**attributes, &content) = nil
	register_element :svg

	# Outputs a `<switch>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/switch
	def switch(**attributes, &content) = nil
	register_element :switch

	# Outputs a `<symbol>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/symbol
	def symbol(**attributes, &content) = nil
	register_element :symbol

	# Outputs a `<text>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/text
	def text(**attributes, &content) = nil
	register_element :text

	# Outputs a `<textPath>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/textPath
	def textPath(**attributes, &content) = nil
	register_element :textPath

	# Outputs a `<title>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/title
	def title(**attributes, &content) = nil
	register_element :title

	# Outputs a `<tspan>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/tspan
	def tspan(**attributes, &content) = nil
	register_element :tspan

	# Outputs a `<use>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/use
	def use(**attributes, &content) = nil
	register_element :use

	# Outputs a `<view>` tag.
	# See https://developer.mozilla.org/docs/Web/SVG/Element/view
	def view(**attributes, &content) = nil
	register_element :view
end
