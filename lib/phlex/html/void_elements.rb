# frozen_string_literal: true

module Phlex::HTML::VoidElements
	extend Phlex::Elements

	# @!method area(**attributes, &content)
	# 	Outputs an <code>area</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/area
	register_void_element :area, tag: "area"

	# @!method br(**attributes, &content)
	# 	Outputs a <code>br</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/br
	register_void_element :br, tag: "br"

	# @!method embed(**attributes, &content)
	# 	Outputs an <code>embed</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/embed
	register_void_element :embed, tag: "embed"

	# @!method hr(**attributes, &content)
	# 	Outputs a <code>hr</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hr
	register_void_element :hr, tag: "hr"

	# @!method img(**attributes, &content)
	# 	Outputs an <code>img</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/img
	register_void_element :img, tag: "img"

	# @!method input(**attributes, &content)
	# 	Outputs an <code>input</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/input
	register_void_element :input, tag: "input"

	# @!method link(**attributes, &content)
	# 	Outputs a <code>link</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/link
	register_void_element :link, tag: "link"

	# @!method meta(**attributes, &content)
	# 	Outputs a <code>meta</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meta
	register_void_element :meta, tag: "meta"

	# @!method param(**attributes, &content)
	# 	Outputs a <code>param</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/param
	register_void_element :param, tag: "param"

	# @!method source(**attributes, &content)
	# 	Outputs a <code>source</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/source
	register_void_element :source, tag: "source"

	# @!method track(**attributes, &content)
	# 	Outputs a <code>track</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/track
	register_void_element :track, tag: "track"

	# @!method col(**attributes, &content)
	# 	Outputs a <code>col</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/col
	register_void_element :col, tag: "col"
end
