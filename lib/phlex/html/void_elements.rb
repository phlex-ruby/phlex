# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex::HTML::VoidElements
	extend Phlex::SGML::Elements

	# @!method area(id: nil, class: nil, **attributes)
	# 	Outputs an `<area>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/area
	__register_void_element__ :area

	# @!method br(id: nil, class: nil, **attributes)
	# 	Outputs a `<br>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/br
	__register_void_element__ :br

	# @!method col(id: nil, class: nil, **attributes)
	# 	Outputs a `<col>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/col
	__register_void_element__ :col

	# @!method embed(id: nil, class: nil, **attributes)
	# 	Outputs an `<embed>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/embed
	__register_void_element__ :embed

	# @!method hr(id: nil, class: nil, **attributes)
	# 	Outputs an `<hr>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hr
	__register_void_element__ :hr

	# @!method img(id: nil, class: nil, src: nil, alt: nil, **attributes)
	# 	Outputs an `<img>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/img
	__register_void_element__ :img

	# @!method input(id: nil, class: nil, type: nil, name: nil, **attributes)
	# 	Outputs an `<input>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/input
	__register_void_element__ :input

	# @!method link(id: nil, class: nil, **attributes)
	# 	Outputs a `<link>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/link
	__register_void_element__ :link

	# @!method meta(id: nil, class: nil, name: nil, charset: nil, **attributes)
	# 	Outputs a `<meta>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meta
	__register_void_element__ :meta

	# @!method source(id: nil, class: nil, **attributes)
	# 	Outputs a `<source>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/source
	__register_void_element__ :source

	# @!method track(id: nil, class: nil, **attributes)
	# 	Outputs a `<track>` tag.
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/track
	__register_void_element__ :track
end
