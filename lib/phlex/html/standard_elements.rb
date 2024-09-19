# frozen_string_literal: true

# Standard HTML elements accept content and always have a closing tag.
module Phlex::HTML::StandardElements
	extend Phlex::SGML::Elements

	# @!method a(id: nil, class: nil, href: nil, target: nil, **attributes, &content)
	# 	Outputs an `<a>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/a
	register_element :a, tag: "a"

	# @!method abbr(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<abbr>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/abbr
	register_element :abbr

	# @!method address(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<address>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/address
	register_element :address

	# @!method article(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<article>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/article
	register_element :article

	# @!method aside(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<aside>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/aside
	register_element :aside

	# @!method audio(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<audio>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
	register_element :audio

	# @!method b(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<b>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/b
	register_element :b

	# @!method base(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<base>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
	register_element :base

	# @!method bdi(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<bdi>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/bdi
	register_element :bdi

	# @!method bdo(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<bdo>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/bdo
	register_element :bdo

	# @!method blockquote(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<blockquote>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/blockquote
	register_element :blockquote

	# @!method body(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<body>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/body
	register_element :body

	# @!method button(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<button>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/button
	register_element :button

	# @!method canvas(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<canvas>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/canvas
	register_element :canvas

	# @!method caption(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<caption>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/caption
	register_element :caption

	# @!method cite(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<cite>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/cite
	register_element :cite

	# @!method code(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<code>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/code
	register_element :code

	# @!method colgroup(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<colgroup>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/colgroup
	register_element :colgroup

	# @!method data(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<data>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/data
	register_element :data

	# @!method datalist(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<datalist>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/datalist
	register_element :datalist

	# @!method dd(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<dd>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dd
	register_element :dd

	# @!method del(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<del>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/del
	register_element :del

	# @!method details(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<details>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/details
	register_element :details

	# @!method dfn(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<dfn>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dfn
	register_element :dfn

	# @!method dialog(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<dialog>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dialog
	register_element :dialog

	# @!method div(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<div>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/div
	register_element :div

	# @!method dl(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<dl>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dl
	register_element :dl

	# @!method dt(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<dt>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dt
	register_element :dt

	# @!method em(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<em>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/em
	register_element :em

	# @!method fieldset(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<fieldset>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/fieldset
	register_element :fieldset

	# @!method figcaption(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<figcaption>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/figcaption
	register_element :figcaption

	# @!method figure(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<figure>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/figure
	register_element :figure

	# @!method footer(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<footer>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/footer
	register_element :footer

	# @!method form(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<form>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/form
	register_element :form

	# @!method h1(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h1>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h1
	register_element :h1

	# @!method h2(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h2>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h2
	register_element :h2

	# @!method h3(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h3>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h3
	register_element :h3

	# @!method h4(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h4>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h4
	register_element :h4

	# @!method h5(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h5>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h5
	register_element :h5

	# @!method h6(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<h6>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h6
	register_element :h6

	# @!method head(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<head>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/head
	register_element :head

	# @!method header(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<header>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/header
	register_element :header

	# @!method hgroup(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<hgroup>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hgroup
	register_element :hgroup

	# @!method html(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<html>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/html
	register_element :html

	# @!method i(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<i>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/i
	register_element :i

	# @!method iframe(id: nil, class: nil, name: nil, src: nil, srcdoc: nil, **attributes, &content)
	# 	Outputs an `<iframe>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/iframe
	register_element :iframe

	# @!method ins(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<ins>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ins
	register_element :ins

	# @!method kbd(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<kbd>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/kbd
	register_element :kbd

	# @!method label(id: nil, class: nil, for: nil, **attributes, &content)
	# 	Outputs a `<label>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/label
	register_element :label

	# @!method legend(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<legend>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/legend
	register_element :legend

	# @!method li(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<li>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/li
	register_element :li

	# @!method main(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<main>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/main
	register_element :main

	# @!method map(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<map>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/map
	register_element :map

	# @!method mark(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<mark>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/mark
	register_element :mark

	# @!method menu(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<menu>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu
	register_element :menu

	# @!method meter(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<meter>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meter
	register_element :meter

	# @!method nav(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<nav>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/nav
	register_element :nav

	# @!method noscript(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<noscript>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/noscript
	register_element :noscript

	# @!method object(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<object>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/object
	register_element :object

	# @!method ol(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<ol>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ol
	register_element :ol

	# @!method optgroup(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<optgroup>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/optgroup
	register_element :optgroup

	# @!method option(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<option>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/option
	register_element :option

	# @!method output(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<output>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/output
	register_element :output

	# @!method p(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<p>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/p
	register_element :p

	# @!method picture(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<picture>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/picture
	register_element :picture

	# @!method portal(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<portal>` tag. (Experimental)
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/portal
	register_element :portal

	# @!method pre(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<pre>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/pre
	register_element :pre

	# @!method progress(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<progress>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/progress
	register_element :progress

	# @!method q(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<q>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/q
	register_element :q

	# @!method rp(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<rp>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/rp
	register_element :rp

	# @!method rt(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<rt>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/rt
	register_element :rt

	# @!method ruby(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<ruby>` tag. (The best tag ever!)
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ruby
	register_element :ruby

	# @!method s(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<s>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/s
	register_element :s

	# @!method samp(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<samp>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/samp
	register_element :samp

	# @!method script(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<script>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/script
	register_element :script

	# @!method search(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<search>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/search
	register_element :search

	# @!method section(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<section>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/section
	register_element :section

	# @!method select(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<select>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/select
	register_element :select

	# @!method slot(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<slot>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/slot
	register_element :slot

	# @!method small(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<small>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/small
	register_element :small

	# @!method span(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<span>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/span
	register_element :span

	# @!method strong(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<strong>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/strong
	register_element :strong

	# @!method style(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<style>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/style
	register_element :style

	# @!method sub(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<sub>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/sub
	register_element :sub

	# @!method summary(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<summary>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/summary
	register_element :summary

	# @!method sup(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<sup>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/sup
	register_element :sup

	# @!method svg(id: nil, class: nil, **attributes, &content)
	# 	Outputs an `<svg>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg
	register_element :svg

	# @!method table(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<table>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/table
	register_element :table

	# @!method tbody(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<tbody>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tbody
	register_element :tbody

	# @!method td(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<td>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/td
	register_element :td

	# @!method template_tag(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<template>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/template
	register_element :template

	# @!method textarea(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<textarea>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/textarea
	register_element :textarea

	# @!method tfoot(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<tfoot>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tfoot
	register_element :tfoot

	# @!method th(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<th>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/th
	register_element :th

	# @!method thead(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<thead>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/thead
	register_element :thead

	# @!method time(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<time>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/time
	register_element :time

	# @!method title(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<title>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/title
	register_element :title

	# @!method tr(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<tr>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tr
	register_element :tr

	# @!method u(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<u>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/u
	register_element :u

	# @!method ul(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<ul>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ul
	register_element :ul

	# @!method var(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<var>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/var
	register_element :var

	# @!method video(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<video>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/video
	register_element :video

	# @!method wbr(id: nil, class: nil, **attributes, &content)
	# 	Outputs a `<wbr>` tag.
	# 	@return [nil]
	# 	@yieldparam component [self]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/wbr
	register_element :wbr
end
