# frozen_string_literal: true

module Phlex::HTML::StandardElements
	extend Phlex::Elements

	REGISTERED_ELEMENTS = Concurrent::Map.new

	# @!method a(**attributes, &content)
	# 	Outputs an <code>a</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/a
	register_element :a, tag: "a"

	# @!method abbr(**attributes, &content)
	# 	Outputs an <code>abbr</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/abbr
	register_element :abbr, tag: "abbr"

	# @!method address(**attributes, &content)
	# 	Outputs an <code>address</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/address
	register_element :address, tag: "address"

	# @!method article(**attributes, &content)
	# 	Outputs an <code>article</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/article
	register_element :article, tag: "article"

	# @!method aside(**attributes, &content)
	# 	Outputs an <code>aside</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/aside
	register_element :aside, tag: "aside"

	# @!method b(**attributes, &content)
	# 	Outputs a <code>b</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/b
	register_element :b, tag: "b"

	# @!method bdi(**attributes, &content)
	# 	Outputs a <code>bdi</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/bdi
	register_element :bdi, tag: "bdi"

	# @!method bdo(**attributes, &content)
	# 	Outputs a <code>bdo</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/bdo
	register_element :bdo, tag: "bdo"

	# @!method blockquote(**attributes, &content)
	# 	Outputs a <code>blockquote</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/blockquote
	register_element :blockquote, tag: "blockquote"

	# @!method body(**attributes, &content)
	# 	Outputs a <code>body</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/body
	register_element :body, tag: "body"

	# @!method button(**attributes, &content)
	# 	Outputs a <code>button</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/button
	register_element :button, tag: "button"

	# @!method caption(**attributes, &content)
	# 	Outputs a <code>caption</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/caption
	register_element :caption, tag: "caption"

	# @!method cite(**attributes, &content)
	# 	Outputs a <code>cite</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/cite
	register_element :cite, tag: "cite"

	# @!method code(**attributes, &content)
	# 	Outputs a <code>code</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/code
	register_element :code, tag: "code"

	# @!method colgroup(**attributes, &content)
	# 	Outputs a <code>colgroup</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/colgroup
	register_element :colgroup, tag: "colgroup"

	# @!method data(**attributes, &content)
	# 	Outputs a <code>data</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/data
	register_element :data, tag: "data"

	# @!method datalist(**attributes, &content)
	# 	Outputs a <code>datalist</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/datalist
	register_element :datalist, tag: "datalist"

	# @!method dd(**attributes, &content)
	# 	Outputs a <code>dd</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dd
	register_element :dd, tag: "dd"

	# @!method del(**attributes, &content)
	# 	Outputs a <code>del</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/del
	register_element :del, tag: "del"

	# @!method details(**attributes, &content)
	# 	Outputs a <code>details</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/details
	register_element :details, tag: "details"

	# @!method dfn(**attributes, &content)
	# 	Outputs a <code>dfn</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dfn
	register_element :dfn, tag: "dfn"

	# @!method dialog(**attributes, &content)
	# 	Outputs a <code>dialog</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dialog
	register_element :dialog, tag: "dialog"

	# @!method div(**attributes, &content)
	# 	Outputs a <code>div</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/div
	register_element :div, tag: "div"

	# @!method dl(**attributes, &content)
	# 	Outputs a <code>dl</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dl
	register_element :dl, tag: "dl"

	# @!method dt(**attributes, &content)
	# 	Outputs a <code>dt</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/dt
	register_element :dt, tag: "dt"

	# @!method em(**attributes, &content)
	# 	Outputs an <code>em</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/em
	register_element :em, tag: "em"

	# @!method fieldset(**attributes, &content)
	# 	Outputs a <code>fieldset</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/fieldset
	register_element :fieldset, tag: "fieldset"

	# @!method figcaption(**attributes, &content)
	# 	Outputs a <code>figcaption</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/figcaption
	register_element :figcaption, tag: "figcaption"

	# @!method figure(**attributes, &content)
	# 	Outputs a <code>figure</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/figure
	register_element :figure, tag: "figure"

	# @!method footer(**attributes, &content)
	# 	Outputs a <code>footer</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/footer
	register_element :footer, tag: "footer"

	# @!method form(**attributes, &content)
	# 	Outputs a <code>form</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/form
	register_element :form, tag: "form"

	# @!method h1(**attributes, &content)
	# 	Outputs an <code>h1</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h1
	register_element :h1, tag: "h1"

	# @!method h2(**attributes, &content)
	# 	Outputs an <code>h2</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h2
	register_element :h2, tag: "h2"

	# @!method h3(**attributes, &content)
	# 	Outputs an <code>h3</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h3
	register_element :h3, tag: "h3"

	# @!method h4(**attributes, &content)
	# 	Outputs an <code>h4</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h4
	register_element :h4, tag: "h4"

	# @!method h5(**attributes, &content)
	# 	Outputs an <code>h5</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h5
	register_element :h5, tag: "h5"

	# @!method h6(**attributes, &content)
	# 	Outputs an <code>h6</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/h6
	register_element :h6, tag: "h6"

	# @!method head(**attributes, &content)
	# 	Outputs a <code>head</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/head
	register_element :head, tag: "head"

	# @!method header(**attributes, &content)
	# 	Outputs a <code>header</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/header
	register_element :header, tag: "header"

	# @!method hgroup(**attributes, &content)
	# 	Outputs a <code>hgroup</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/hgroup
	register_element :hgroup, tag: "hgroup"

	# @!method html(**attributes, &content)
	# 	Outputs a <code>html</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/html
	register_element :html, tag: "html"

	# @!method i(**attributes, &content)
	# 	Outputs an <code>i</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/i
	register_element :i, tag: "i"

	# @!method iframe(**attributes, &content)
	# 	Outputs an <code>iframe</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/iframe
	register_element :iframe, tag: "iframe"

	# @!method ins(**attributes, &content)
	# 	Outputs an <code>ins</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ins
	register_element :ins, tag: "ins"

	# @!method kbd(**attributes, &content)
	# 	Outputs a <code>kbd</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/kbd
	register_element :kbd, tag: "kbd"

	# @!method label(**attributes, &content)
	# 	Outputs a <code>label</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/label
	register_element :label, tag: "label"

	# @!method legend(**attributes, &content)
	# 	Outputs a <code>legend</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/legend
	register_element :legend, tag: "legend"

	# @!method li(**attributes, &content)
	# 	Outputs a <code>li</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/li
	register_element :li, tag: "li"

	# @!method main(**attributes, &content)
	# 	Outputs a <code>main</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/main
	register_element :main, tag: "main"

	# @!method map(**attributes, &content)
	# 	Outputs a <code>map</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/map
	register_element :map, tag: "map"

	# @!method mark(**attributes, &content)
	# 	Outputs a <code>mark</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/mark
	register_element :mark, tag: "mark"

	# @!method menuitem(**attributes, &content)
	# 	Outputs a <code>menuitem</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/menuitem
	# 	@deprecated
	register_element :menuitem, tag: "menuitem"

	# @!method meter(**attributes, &content)
	# 	Outputs a <code>meter</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/meter
	register_element :meter, tag: "meter"

	# @!method nav(**attributes, &content)
	# 	Outputs a <code>nav</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/nav
	register_element :nav, tag: "nav"

	# @!method noscript(**attributes, &content)
	# 	Outputs a <code>noscript</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/noscript
	register_element :noscript, tag: "noscript"

	# @!method object(**attributes, &content)
	# 	Outputs an <code>object</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/object
	register_element :object, tag: "object"

	# @!method ol(**attributes, &content)
	# 	Outputs an <code>ol</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ol
	register_element :ol, tag: "ol"

	# @!method optgroup(**attributes, &content)
	# 	Outputs an <code>optgroup</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/optgroup
	register_element :optgroup, tag: "optgroup"

	# @!method option(**attributes, &content)
	# 	Outputs an <code>option</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/option
	register_element :option, tag: "option"

	# @!method output(**attributes, &content)
	# 	Outputs an <code>output</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/output
	register_element :output, tag: "output"

	# @!method p(**attributes, &content)
	# 	Outputs a <code>p</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/p
	register_element :p, tag: "p"

	# @!method picture(**attributes, &content)
	# 	Outputs a <code>picture</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/picture
	register_element :picture, tag: "picture"

	# @!method pre(**attributes, &content)
	# 	Outputs a <code>pre</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/pre
	register_element :pre, tag: "pre"

	# @!method progress(**attributes, &content)
	# 	Outputs a <code>progress</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/progress
	register_element :progress, tag: "progress"

	# @!method q(**attributes, &content)
	# 	Outputs a <code>q</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/q
	register_element :q, tag: "q"

	# @!method rp(**attributes, &content)
	# 	Outputs a <code>rp</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/rp
	register_element :rp, tag: "rp"

	# @!method rt(**attributes, &content)
	# 	Outputs a <code>rt</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/rt
	register_element :rt, tag: "rt"

	# @!method ruby(**attributes, &content)
	# 	Outputs a <code>ruby</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ruby
	register_element :ruby, tag: "ruby"

	# @!method s(**attributes, &content)
	# 	Outputs a <code>s</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/s
	register_element :s, tag: "s"

	# @!method samp(**attributes, &content)
	# 	Outputs a <code>samp</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/samp
	register_element :samp, tag: "samp"

	# @!method script(**attributes, &content)
	# 	Outputs a <code>script</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/script
	register_element :script, tag: "script"

	# @!method section(**attributes, &content)
	# 	Outputs a <code>section</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/section
	register_element :section, tag: "section"

	# @!method select(**attributes, &content)
	# 	Outputs a <code>select</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/select
	register_element :select, tag: "select"

	# @!method slot(**attributes, &content)
	# 	Outputs a <code>slot</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/slot
	register_element :slot, tag: "slot"

	# @!method small(**attributes, &content)
	# 	Outputs a <code>small</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/small
	register_element :small, tag: "small"

	# @!method span(**attributes, &content)
	# 	Outputs a <code>span</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/span
	register_element :span, tag: "span"

	# @!method strong(**attributes, &content)
	# 	Outputs a <code>strong</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/strong
	register_element :strong, tag: "strong"

	# @!method style(**attributes, &content)
	# 	Outputs a <code>style</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/style
	register_element :style, tag: "style"

	# @!method sub(**attributes, &content)
	# 	Outputs a <code>sub</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/sub
	register_element :sub, tag: "sub"

	# @!method summary(**attributes, &content)
	# 	Outputs a <code>summary</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/summary
	register_element :summary, tag: "summary"

	# @!method sup(**attributes, &content)
	# 	Outputs a <code>sup</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/sup
	register_element :sup, tag: "sup"

	# @!method svg(**attributes, &content)
	# 	Outputs a <code>svg</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg
	register_element :svg, tag: "svg"

	# @!method table(**attributes, &content)
	# 	Outputs a <code>table</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/table
	register_element :table, tag: "table"

	# @!method tbody(**attributes, &content)
	# 	Outputs a <code>tbody</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tbody
	register_element :tbody, tag: "tbody"

	# @!method td(**attributes, &content)
	# 	Outputs a <code>td</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/td
	register_element :td, tag: "td"

	# @!method template_tag(**attributes, &content)
	# 	Outputs a <code>template</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/template
	register_element :template_tag, tag: "template"

	# @!method textarea(**attributes, &content)
	# 	Outputs a <code>textarea</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/textarea
	register_element :textarea, tag: "textarea"

	# @!method tfoot(**attributes, &content)
	# 	Outputs a <code>tfoot</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tfoot
	register_element :tfoot, tag: "tfoot"

	# @!method th(**attributes, &content)
	# 	Outputs a <code>th</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/th
	register_element :th, tag: "th"

	# @!method thead(**attributes, &content)
	# 	Outputs a <code>thead</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/thead
	register_element :thead, tag: "thead"

	# @!method time(**attributes, &content)
	# 	Outputs a <code>time</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/time
	register_element :time, tag: "time"

	# @!method title(**attributes, &content)
	# 	Outputs a <code>title</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/title
	register_element :title, tag: "title"

	# @!method tr(**attributes, &content)
	# 	Outputs a <code>tr</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/tr
	register_element :tr, tag: "tr"

	# @!method u(**attributes, &content)
	# 	Outputs an <code>u</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/u
	register_element :u, tag: "u"

	# @!method ul(**attributes, &content)
	# 	Outputs an <code>ul</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/ul
	register_element :ul, tag: "ul"

	# @!method video(**attributes, &content)
	# 	Outputs a <code>video</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/video
	register_element :video, tag: "video"

	# @!method wbr(**attributes, &content)
	# 	Outputs a <code>wbr</code> tag
	# 	@return [nil]
	# 	@see https://developer.mozilla.org/docs/Web/HTML/Element/wbr
	register_element :wbr, tag: "wbr"
end
