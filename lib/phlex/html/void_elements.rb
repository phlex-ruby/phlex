# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex::HTML::VoidElements
	extend Phlex::Elements

	# @!method area(**attributes, &content)
	# 	Outputs an `<area>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/area
	register_void_element :area, tag: "area"

	# @!method br(**attributes, &content)
	# 	Outputs a `<br>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/br
	register_void_element :br, tag: "br"

	# @!method col(**attributes, &content)
	# 	Outputs a `<col>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/col
	register_void_element :col, tag: "col"

	# @!method embed(**attributes, &content)
	# 	Outputs an `<embed>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/embed
	register_void_element :embed, tag: "embed"

	# @!method hr(**attributes, &content)
	# 	Outputs an `<hr>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hr
	register_void_element :hr, tag: "hr"

	# @!method img(**attributes, &content)
	# 	Outputs an `<img>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/img
	register_void_element :img, tag: "img"

	# @!method input(**attributes, &content)
	# 	Outputs an `<input>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/input
	register_void_element :input, tag: "input"

	# @!method link(**attributes, &content)
	# 	Outputs a `<link>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/link
	register_void_element :link, tag: "link"

	# @!method meta(**attributes, &content)
	# 	Outputs a `<meta>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meta
	register_void_element :meta, tag: "meta"

	# @!method param(**attributes, &content)
	# 	Outputs a `<param>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/param
	register_void_element :param, tag: "param", deprecated: true

	# @!method source(**attributes, &content)
	# 	Outputs a `<source>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/source
	register_void_element :source, tag: "source"

	# @!method track(**attributes, &content)
	# 	Outputs a `<track>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/track
	register_void_element :track, tag: "track"
end
