# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex::HTML::VoidElements
	extend Phlex::SGML::Elements

	# Outputs an `<area>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/area
	__register_void_element__ def area(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs a `<base>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
	__register_void_element__ def base(
		class: nil,
		href: nil,
		id: nil,
		target: nil,
		**attributes
	) = nil
	# Outputs a `<br>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/br
	__register_void_element__ def br(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs a `<col>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/col
	__register_void_element__ def col(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs an `<embed>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/embed
	__register_void_element__ def embed(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs an `<hr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/hr
	__register_void_element__ def hr(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs an `<img>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/img
	__register_void_element__ def img(
		alt: nil,
		class: nil,
		id: nil,
		src: nil,
		**attributes
	) = nil
	# Outputs an `<input>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/input
	__register_void_element__ def input(
		class: nil,
		id: nil,
		name: nil,
		type: nil,
		**attributes
	) = nil
	# Outputs a `<link>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/link
	__register_void_element__ def link(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs a `<meta>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/meta
	__register_void_element__ def meta(
		charset: nil,
		class: nil,
		id: nil,
		name: nil,
		**attributes
	) = nil
	# Outputs a `<source>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/source
	__register_void_element__ def source(
		class: nil,
		id: nil,
		**attributes
	) = nil
	# Outputs a `<track>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/track
	__register_void_element__ def track(
		class: nil,
		id: nil,
		**attributes
	) = nil
end
