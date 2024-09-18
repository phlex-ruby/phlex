# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex::HTML::VoidElements
	extend Phlex::SGML::Elements

	# @!method area(**attributes, &content)
	# 	Outputs an `<area>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/area
	__register_void_element__ :area

	# @!method br(**attributes, &content)
	# 	Outputs a `<br>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/br
	__register_void_element__ :br

	# @!method col(**attributes, &content)
	# 	Outputs a `<col>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/col
	__register_void_element__ :col

	# @!method embed(**attributes, &content)
	# 	Outputs an `<embed>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/embed
	__register_void_element__ :embed

	# @!method hr(**attributes, &content)
	# 	Outputs an `<hr>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hr
	__register_void_element__ :hr

	# @!method img(**attributes, &content)
	# 	Outputs an `<img>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/img
	__register_void_element__ :img

	# @!method input(**attributes, &content)
	# 	Outputs an `<input>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/input
	__register_void_element__ :input

	# @!method link(**attributes, &content)
	# 	Outputs a `<link>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/link
	__register_void_element__ :link

	# @!method meta(**attributes, &content)
	# 	Outputs a `<meta>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meta
	__register_void_element__ :meta

	# @!method source(**attributes, &content)
	# 	Outputs a `<source>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/source
	__register_void_element__ :source

	# @!method track(**attributes, &content)
	# 	Outputs a `<track>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/track
	__register_void_element__ :track
end
