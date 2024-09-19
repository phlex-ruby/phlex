# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex::HTML::VoidElements
	extend Phlex::SGML::Elements

	# Outputs an `<area>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/area
	def area(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :area

	# Outputs a `<br>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/br
	def br(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :br

	# Outputs a `<col>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/col
	def col(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :col

	# Outputs an `<embed>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/embed
	def embed(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :embed

	# Outputs an `<hr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/hr
	def hr(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :hr

	# Outputs an `<img>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/img
	def img(id: nil, class: nil, src: nil, alt: nil, **attributes) = nil
	__register_void_element__ :img

	# Outputs an `<input>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/input
	def input(id: nil, class: nil, type: nil, name: nil, **attributes) = nil
	__register_void_element__ :input

	# Outputs a `<link>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/link
	def link(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :link

	# Outputs a `<meta>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/meta
	def meta(id: nil, class: nil, name: nil, charset: nil, **attributes) = nil
	__register_void_element__ :meta

	# Outputs a `<source>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/source
	def source(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :source

	# Outputs a `<track>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/track
	def track(id: nil, class: nil, **attributes) = nil
	__register_void_element__ :track
end
