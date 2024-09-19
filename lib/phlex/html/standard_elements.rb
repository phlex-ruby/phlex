# frozen_string_literal: true

# Standard HTML elements accept content and always have a closing tag.
module Phlex::HTML::StandardElements
	extend Phlex::SGML::Elements

	# Outputs an `<a>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/a
	def a(id: nil, class: nil, href: nil, target: nil, **attributes, &content) = nil
	register_element :a, tag: "a"

	# Outputs an `<abbr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/abbr
	def abbr(id: nil, class: nil, **attributes, &content) = nil
	register_element :abbr

	# Outputs an `<address>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/address
	def address(id: nil, class: nil, **attributes, &content) = nil
	register_element :address

	# Outputs an `<article>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/article
	def article(id: nil, class: nil, **attributes, &content) = nil
	register_element :article

	# Outputs an `<aside>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/aside
	def aside(id: nil, class: nil, **attributes, &content) = nil
	register_element :aside

	# Outputs an `<audio>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
	def audio(id: nil, class: nil, **attributes, &content) = nil
	register_element :audio

	# Outputs a `<b>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/b
	def b(id: nil, class: nil, **attributes, &content) = nil
	register_element :b

	# Outputs a `<base>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base
	def base(id: nil, class: nil, **attributes, &content) = nil
	register_element :base

	# Outputs a `<bdi>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/bdi
	def bdi(id: nil, class: nil, **attributes, &content) = nil
	register_element :bdi

	# Outputs a `<bdo>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/bdo
	def bdo(id: nil, class: nil, **attributes, &content) = nil
	register_element :bdo

	# Outputs a `<blockquote>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/blockquote
	def blockquote(id: nil, class: nil, **attributes, &content) = nil
	register_element :blockquote

	# Outputs a `<body>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/body
	def body(id: nil, class: nil, **attributes, &content) = nil
	register_element :body

	# Outputs a `<button>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/button
	def button(id: nil, class: nil, **attributes, &content) = nil
	register_element :button

	# Outputs a `<canvas>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/canvas
	def canvas(id: nil, class: nil, **attributes, &content) = nil
	register_element :canvas

	# Outputs a `<caption>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/caption
	def caption(id: nil, class: nil, **attributes, &content) = nil
	register_element :caption

	# Outputs a `<cite>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/cite
	def cite(id: nil, class: nil, **attributes, &content) = nil
	register_element :cite

	# Outputs a `<code>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/code
	def code(id: nil, class: nil, **attributes, &content) = nil
	register_element :code

	# Outputs a `<colgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/colgroup
	def colgroup(id: nil, class: nil, **attributes, &content) = nil
	register_element :colgroup

	# Outputs a `<data>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/data
	def data(id: nil, class: nil, **attributes, &content) = nil
	register_element :data

	# Outputs a `<datalist>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/datalist
	def datalist(id: nil, class: nil, **attributes, &content) = nil
	register_element :datalist

	# Outputs a `<dd>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dd
	def dd(id: nil, class: nil, **attributes, &content) = nil
	register_element :dd

	# Outputs a `<del>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/del
	def del(id: nil, class: nil, **attributes, &content) = nil
	register_element :del

	# Outputs a `<details>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/details
	def details(id: nil, class: nil, **attributes, &content) = nil
	register_element :details

	# Outputs a `<dfn>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dfn
	def dfn(id: nil, class: nil, **attributes, &content) = nil
	register_element :dfn

	# Outputs a `<dialog>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dialog
	def dialog(id: nil, class: nil, **attributes, &content) = nil
	register_element :dialog

	# Outputs a `<div>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/div
	def div(id: nil, class: nil, **attributes, &content) = nil
	register_element :div

	# Outputs a `<dl>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dl
	def dl(id: nil, class: nil, **attributes, &content) = nil
	register_element :dl

	# Outputs a `<dt>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/dt
	def dt(id: nil, class: nil, **attributes, &content) = nil
	register_element :dt

	# Outputs an `<em>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/em
	def em(id: nil, class: nil, **attributes, &content) = nil
	register_element :em

	# Outputs a `<fieldset>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/fieldset
	def fieldset(id: nil, class: nil, **attributes, &content) = nil
	register_element :fieldset

	# Outputs a `<figcaption>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/figcaption
	def figcaption(id: nil, class: nil, **attributes, &content) = nil
	register_element :figcaption

	# Outputs a `<figure>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/figure
	def figure(id: nil, class: nil, **attributes, &content) = nil
	register_element :figure

	# Outputs a `<footer>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/footer
	def footer(id: nil, class: nil, **attributes, &content) = nil
	register_element :footer

	# Outputs a `<form>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/form
	def form(id: nil, class: nil, **attributes, &content) = nil
	register_element :form

	# Outputs an `<h1>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h1
	def h1(id: nil, class: nil, **attributes, &content) = nil
	register_element :h1

	# Outputs an `<h2>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h2
	def h2(id: nil, class: nil, **attributes, &content) = nil
	register_element :h2

	# Outputs an `<h3>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h3
	def h3(id: nil, class: nil, **attributes, &content) = nil
	register_element :h3

	# Outputs an `<h4>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h4
	def h4(id: nil, class: nil, **attributes, &content) = nil
	register_element :h4

	# Outputs an `<h5>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h5
	def h5(id: nil, class: nil, **attributes, &content) = nil
	register_element :h5

	# Outputs an `<h6>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/h6
	def h6(id: nil, class: nil, **attributes, &content) = nil
	register_element :h6

	# Outputs a `<head>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/head
	def head(id: nil, class: nil, **attributes, &content) = nil
	register_element :head

	# Outputs a `<header>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/header
	def header(id: nil, class: nil, **attributes, &content) = nil
	register_element :header

	# Outputs an `<hgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/hgroup
	def hgroup(id: nil, class: nil, **attributes, &content) = nil
	register_element :hgroup

	# Outputs an `<html>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/html
	def html(id: nil, class: nil, **attributes, &content) = nil
	register_element :html

	# Outputs an `<i>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/i
	def i(id: nil, class: nil, **attributes, &content) = nil
	register_element :i

	# Outputs an `<iframe>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/iframe
	def iframe(id: nil, class: nil, name: nil, src: nil, srcdoc: nil, **attributes, &content) = nil
	register_element :iframe

	# Outputs an `<ins>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ins
	def ins(id: nil, class: nil, **attributes, &content) = nil
	register_element :ins

	# Outputs a `<kbd>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/kbd
	def kbd(id: nil, class: nil, **attributes, &content) = nil
	register_element :kbd

	# Outputs a `<label>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/label
	def label(id: nil, class: nil, for: nil, **attributes, &content) = nil
	register_element :label

	# Outputs a `<legend>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/legend
	def legend(id: nil, class: nil, **attributes, &content) = nil
	register_element :legend

	# Outputs a `<li>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/li
	def li(id: nil, class: nil, **attributes, &content) = nil
	register_element :li

	# Outputs a `<main>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/main
	def main(id: nil, class: nil, **attributes, &content) = nil
	register_element :main

	# Outputs a `<map>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/map
	def map(id: nil, class: nil, **attributes, &content) = nil
	register_element :map

	# Outputs a `<mark>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/mark
	def mark(id: nil, class: nil, **attributes, &content) = nil
	register_element :mark

	# Outputs a `<menu>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu
	def menu(id: nil, class: nil, **attributes, &content) = nil
	register_element :menu

	# Outputs a `<meter>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/meter
	def meter(id: nil, class: nil, **attributes, &content) = nil
	register_element :meter

	# Outputs a `<nav>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/nav
	def nav(id: nil, class: nil, **attributes, &content) = nil
	register_element :nav

	# Outputs a `<noscript>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/noscript
	def noscript(id: nil, class: nil, **attributes, &content) = nil
	register_element :noscript

	# Outputs an `<object>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/object
	def object(id: nil, class: nil, **attributes, &content) = nil
	register_element :object

	# Outputs an `<ol>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ol
	def ol(id: nil, class: nil, **attributes, &content) = nil
	register_element :ol

	# Outputs an `<optgroup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/optgroup
	def optgroup(id: nil, class: nil, **attributes, &content) = nil
	register_element :optgroup

	# Outputs an `<option>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/option
	def option(id: nil, class: nil, **attributes, &content) = nil
	register_element :option

	# Outputs an `<output>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/output
	def output(id: nil, class: nil, **attributes, &content) = nil
	register_element :output

	# Outputs a `<p>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/p
	def p(id: nil, class: nil, **attributes, &content) = nil
	register_element :p

	# Outputs a `<picture>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/picture
	def picture(id: nil, class: nil, **attributes, &content) = nil
	register_element :picture

	# Outputs a `<portal>` tag. (Experimental)
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/portal
	def portal(id: nil, class: nil, **attributes, &content) = nil
	register_element :portal

	# Outputs a `<pre>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/pre
	def pre(id: nil, class: nil, **attributes, &content) = nil
	register_element :pre

	# Outputs a `<progress>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/progress
	def progress(id: nil, class: nil, **attributes, &content) = nil
	register_element :progress

	# Outputs a `<q>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/q
	def q(id: nil, class: nil, **attributes, &content) = nil
	register_element :q

	# Outputs an `<rp>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/rp
	def rp(id: nil, class: nil, **attributes, &content) = nil
	register_element :rp

	# Outputs an `<rt>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/rt
	def rt(id: nil, class: nil, **attributes, &content) = nil
	register_element :rt

	# Outputs a `<ruby>` tag. (The best tag ever!)
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ruby
	def ruby(id: nil, class: nil, **attributes, &content) = nil
	register_element :ruby

	# Outputs an `<s>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/s
	def s(id: nil, class: nil, **attributes, &content) = nil
	register_element :s

	# Outputs a `<samp>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/samp
	def samp(id: nil, class: nil, **attributes, &content) = nil
	register_element :samp

	# Outputs a `<script>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/script
	def script(id: nil, class: nil, **attributes, &content) = nil
	register_element :script

	# Outputs a `<search>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/search
	def search(id: nil, class: nil, **attributes, &content) = nil
	register_element :search

	# Outputs a `<section>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/section
	def section(id: nil, class: nil, **attributes, &content) = nil
	register_element :section

	# Outputs a `<select>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/select
	def select(id: nil, class: nil, **attributes, &content) = nil
	register_element :select

	# Outputs a `<slot>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/slot
	def slot(id: nil, class: nil, **attributes, &content) = nil
	register_element :slot

	# Outputs a `<small>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/small
	def small(id: nil, class: nil, **attributes, &content) = nil
	register_element :small

	# Outputs a `<span>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/span
	def span(id: nil, class: nil, **attributes, &content) = nil
	register_element :span

	# Outputs a `<strong>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/strong
	def strong(id: nil, class: nil, **attributes, &content) = nil
	register_element :strong

	# Outputs a `<style>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/style
	def style(id: nil, class: nil, **attributes, &content) = nil
	register_element :style

	# Outputs a `<sub>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/sub
	def sub(id: nil, class: nil, **attributes, &content) = nil
	register_element :sub

	# Outputs a `<summary>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/summary
	def summary(id: nil, class: nil, **attributes, &content) = nil
	register_element :summary

	# Outputs a `<sup>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/sup
	def sup(id: nil, class: nil, **attributes, &content) = nil
	register_element :sup

	# Outputs an `<svg>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg
	def svg(id: nil, class: nil, **attributes, &content) = nil
	register_element :svg

	# Outputs a `<table>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/table
	def table(id: nil, class: nil, **attributes, &content) = nil
	register_element :table

	# Outputs a `<tbody>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tbody
	def tbody(id: nil, class: nil, **attributes, &content) = nil
	register_element :tbody

	# Outputs a `<td>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/td
	def td(id: nil, class: nil, **attributes, &content) = nil
	register_element :td

	# Outputs a `<template>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/template
	def template_tag(id: nil, class: nil, **attributes, &content) = nil
	register_element :template

	# Outputs a `<textarea>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/textarea
	def textarea(id: nil, class: nil, **attributes, &content) = nil
	register_element :textarea

	# Outputs a `<tfoot>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tfoot
	def tfoot(id: nil, class: nil, **attributes, &content) = nil
	register_element :tfoot

	# Outputs a `<th>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/th
	def th(id: nil, class: nil, **attributes, &content) = nil
	register_element :th

	# Outputs a `<thead>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/thead
	def thead(id: nil, class: nil, **attributes, &content) = nil
	register_element :thead

	# Outputs a `<time>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/time
	def time(id: nil, class: nil, **attributes, &content) = nil
	register_element :time

	# Outputs a `<title>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/title
	def title(id: nil, class: nil, **attributes, &content) = nil
	register_element :title

	# Outputs a `<tr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/tr
	def tr(id: nil, class: nil, **attributes, &content) = nil
	register_element :tr

	# Outputs a `<u>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/u
	def u(id: nil, class: nil, **attributes, &content) = nil
	register_element :u

	# Outputs a `<ul>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/ul
	def ul(id: nil, class: nil, **attributes, &content) = nil
	register_element :ul

	# Outputs a `<var>` tag.
	# See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/var
	def var(id: nil, class: nil, **attributes, &content) = nil
	register_element :var

	# Outputs a `<video>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/video
	def video(id: nil, class: nil, **attributes, &content) = nil
	register_element :video

	# Outputs a `<wbr>` tag.
	# See https://developer.mozilla.org/docs/Web/HTML/Element/wbr
	def wbr(id: nil, class: nil, **attributes, &content) = nil
	register_element :wbr
end
