# frozen_string_literal: true

# Standard HTML elements accept content and always have a closing tag.
module Phlex::HTML::StandardElements
	extend Phlex::SGML::Elements

	# Outputs an `<a>` tag.
	# The `<a>` element creates a hyperlink to web pages, files, email addresses, locations in the same page, or anything else a URL can address.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/a
	register_element def a(
		class: nil,
		href: nil,
		id: nil,
		rel: nil,
		target: nil,
		title: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<abbr>` tag.
	# The `<abbr>` element represents an abbreviation or acronym.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/abbr
	register_element def abbr(
		class: nil,
		id: nil,
		title: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<address>` tag.
	# The `<address>` element indicates contact information for a person or organization.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/address
	register_element def address(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<article>` tag.
	# The `<article>` element represents a self-contained composition in a document, page, application, or site.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/article
	register_element def article(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<aside>` tag.
	# The `<aside>` element represents a section of a page that consists of content that is tangentially related to the content around the aside element.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/aside
	register_element def aside(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<audio>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
	def audio(
		autoplay: nil,
		class: nil,
		controls: nil,
		id: nil,
		loop: nil,
		src: nil,
		**attributes,
		&content
	) = nil
	register_element :audio

	# Outputs a `<b>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/b
	def b(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil
	register_element :b

	# Outputs a `<base>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
	def base(
		class: nil,
		href: nil,
		id: nil,
		target: nil,
		**attributes,
		&content
	) = nil
	register_element :base

	# Outputs a `<bdi>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/bdi
	def bdi(id: nil, class: nil, **attributes, &content) = nil
	register_element :bdi

	# Outputs a `<bdo>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/bdo
	def bdo(id: nil, class: nil, dir: nil, **attributes, &content) = nil
	register_element :bdo

	# Outputs a `<blockquote>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/blockquote
	def blockquote(id: nil, class: nil, cite: nil, **attributes, &content) = nil
	register_element :blockquote

	# Outputs a `<body>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/body
	def body(id: nil, class: nil, **attributes, &content) = nil
	register_element :body

	# Outputs a `<button>` tag.
	# The `<button>` element is an interactive element activated by a user with a mouse, keyboard, finger, voice command, or other assistive technology to perform an action, such as submitting a form or opening a dialog.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/button
	register_element def button(
		autofocus: nil,
		class: nil,
		disabled: nil,
		form: nil,
		formaction: nil,
		formmethod: nil,
		formtarget: nil,
		formvalidate: nil,
		id: nil,
		name: nil,
		popovertarget: nil,
		popovertargetaction: nil,
		type: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<canvas>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/canvas
	register_element def canvas(
		class: nil,
		height: nil,
		id: nil,
		width: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<caption>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/caption
	register_element def caption(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<cite>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/cite
	register_element def cite(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<code>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/code
	register_element def code(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<colgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/colgroup
	register_element def colgroup(
		class: nil,
		id: nil,
		span: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<data>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/data
	register_element def data(
		class: nil,
		id: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<datalist>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/datalist
	register_element def datalist(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<dd>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dd
	register_element def dd(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<del>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/del
	register_element def del(
		cite: nil,
		class: nil,
		datetime: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<details>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/details
	register_element def details(
		class: nil,
		id: nil,
		open: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<dfn>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dfn
	register_element def dfn(
		class: nil,
		id: nil,
		title: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<dialog>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dialog
	register_element def dialog(
		class: nil,
		id: nil,
		open: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<div>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/div
	register_element def div(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<dl>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dl
	register_element def dl(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<dt>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dt
	register_element def dt(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<em>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/em
	register_element def em(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<fieldset>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/fieldset
	register_element def fieldset(
		class: nil,
		disabled: nil,
		form: nil,
		id: nil,
		name: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<figcaption>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/figcaption
	register_element def figcaption(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<figure>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/figure
	register_element def figure(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<footer>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/footer
	register_element def footer(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<form>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/form
	register_element def form(
		action: nil,
		class: nil,
		enctype: nil,
		id: nil,
		method: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h1>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h1
	register_element def h1(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h2>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h2
	register_element def h2(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h3>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h3
	register_element def h3(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h4>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h4
	register_element def h4(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h5>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h5
	register_element def h5(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<h6>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h6
	register_element def h6(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<head>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/head
	register_element def head(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<header>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/header
	register_element def header(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<hgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/hgroup
	register_element def hgroup(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<html>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/html
	register_element def html(
		class: nil,
		id: nil,
		lang: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<i>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/i
	register_element def i(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<iframe>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/iframe
	register_element def iframe(
		class: nil,
		height: nil,
		id: nil,
		name: nil,
		src: nil,
		srcdoc: nil,
		width: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<ins>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ins
	register_element def ins(
		cite: nil,
		class: nil,
		datetime: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<kbd>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/kbd
	register_element def kbd(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<label>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/label
	register_element def label(
		class: nil,
		for: nil,
		form: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<legend>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/legend
	register_element def legend(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<li>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/li
	register_element def li(
		class: nil,
		id: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<main>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/main
	register_element def main(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<map>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/map
	register_element def map(
		class: nil,
		id: nil,
		name: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<mark>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/mark
	register_element def mark(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<menu>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu
	register_element def menu(
		class: nil,
		id: nil,
		type: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<meter>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/meter
	register_element def meter(
		class: nil,
		high: nil,
		id: nil,
		low: nil,
		max: nil,
		min: nil,
		optimum: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<nav>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/nav
	register_element def nav(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<noscript>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/noscript
	register_element def noscript(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<object>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/object
	register_element def object(
		class: nil,
		data: nil,
		height: nil,
		id: nil,
		type: nil,
		width: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<ol>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ol
	register_element def ol(
		class: nil,
		id: nil,
		reversed: nil,
		start: nil,
		type: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<optgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/optgroup
	register_element def optgroup(
		class: nil,
		disabled: nil,
		id: nil,
		label: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<option>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/option
	register_element def option(
		class: nil,
		disabled: nil,
		id: nil,
		selected: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<output>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/output
	register_element def output(
		class: nil,
		for: nil,
		form: nil,
		id: nil,
		name: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<p>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/p
	register_element def p(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<picture>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/picture
	register_element def picture(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<portal>` tag. (Experimental)
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/portal
	register_element def portal(
		class: nil,
		id: nil,
		src: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<pre>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/pre
	register_element def pre(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<progress>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/progress
	register_element def progress(
		class: nil,
		id: nil,
		max: nil,
		value: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<q>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/q
	register_element def q(
		cite: nil,
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<rp>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/rp
	register_element def rp(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<rt>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/rt
	register_element def rt(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<ruby>` tag. (The best tag ever!)
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ruby
	register_element def ruby(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<s>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/s
	register_element def s(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<samp>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/samp
	register_element def samp(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<script>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/script
	register_element def script(
		async: nil,
		class: nil,
		defer: nil,
		id: nil,
		src: nil,
		type: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<search>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/search
	register_element def search(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<section>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/section
	register_element def section(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<select>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/select
	register_element def select(
		class: nil,
		id: nil,
		multiple: nil,
		name: nil,
		size: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<slot>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/slot
	register_element def slot(
		class: nil,
		id: nil,
		name: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<small>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/small
	register_element def small(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<span>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/span
	register_element def span(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<strong>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/strong
	register_element def strong(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<style>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/style
	register_element def style(
		class: nil,
		id: nil,
		media: nil,
		type: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<sub>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/sub
	register_element def sub(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<summary>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/summary
	register_element def summary(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<sup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/sup
	register_element def sup(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs an `<svg>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg
	register_element def svg(
		class: nil,
		height: nil,
		id: nil,
		viewBox: nil,
		width: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<table>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/table
	register_element def table(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<tbody>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tbody
	register_element def tbody(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<td>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/td
	register_element def td(
		class: nil,
		colspan: nil,
		headers: nil,
		id: nil,
		rowspan: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<template>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/template
	register_element def template(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<textarea>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/textarea
	register_element def textarea(
		class: nil,
		cols: nil,
		disabled: nil,
		id: nil,
		name: nil,
		readonly: nil,
		rows: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<tfoot>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tfoot
	register_element def tfoot(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<th>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/th
	register_element def th(
		class: nil,
		colspan: nil,
		headers: nil,
		id: nil,
		rowspan: nil,
		scope: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<thead>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/thead
	register_element def thead(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<time>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/time
	register_element def time(
		class: nil,
		datetime: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<title>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/title
	register_element def title(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<tr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tr
	register_element def tr(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<u>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/u
	register_element def u(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<ul>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ul
	register_element def ul(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<var>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/var
	register_element def var(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<video>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/video
	register_element def video(
		autoplay: nil,
		class: nil,
		controls: nil,
		height: nil,
		id: nil,
		loop: nil,
		src: nil,
		width: nil,
		**attributes,
		&content
	) = nil

	# Outputs a `<wbr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/wbr
	register_element def wbr(
		class: nil,
		id: nil,
		**attributes,
		&content
	) = nil
end
