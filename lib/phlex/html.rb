# frozen_string_literal: true

class Phlex::HTML < Phlex::SGML
	autoload :StandardElements, "phlex/html/standard_elements"
	autoload :VoidElements, "phlex/html/void_elements"

	# A list of HTML attributes that have the potential to execute unsafe JavaScript.
	UNSAFE_ATTRIBUTES = Set.new(%w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel srcdoc]).freeze

	extend Phlex::Elements
	include VoidElements, StandardElements

	# Output an HTML doctype.
	def doctype
		context = @_context
		return if context.fragments && !context.in_target_fragment

		context.buffer << "<!doctype html>"
		nil
	end

	# Outputs an `<svg>` tag
	# @return [nil]
	# @see https://developer.mozilla.org/docs/Web/SVG/Element/svg
	def svg(...)
		if block_given?
			super do
				render Phlex::SVG.new do |svg|
					yield(svg)
				end
			end
		else
			super
		end
	end

	def filename
		nil
	end

	def content_type
		"text/html"
	end

	# This should be extended after all method definitions
	extend Phlex::ElementClobberingGuard
end
