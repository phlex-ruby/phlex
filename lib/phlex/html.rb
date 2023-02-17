# frozen_string_literal: true

module Phlex
	class HTML < SGML
		# A list of HTML attributes that have the potential to execute unsafe JavaScript.
		EVENT_ATTRIBUTES = %w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

		UNBUFFERED_MUTEX = Mutex.new

		class << self
			# @api private
			def __unbuffered_class__
				UNBUFFERED_MUTEX.synchronize do
					if defined? @unbuffered_class
						@unbuffered_class
					else
						@unbuffered_class = Class.new(Unbuffered)
					end
				end
			end
		end

		extend Elements
		include Helpers, VoidElements, StandardElements

		# Output an HTML doctype.
		def doctype
			@_target << "<!DOCTYPE html>"
			nil
		end

		def svg(...)
			super do
				render Phlex::SVG.new do |svg|
					yield(svg)
				end
			end
		end

		# @api private
		def unbuffered
			self.class.__unbuffered_class__.new(self)
		end

		# This should be the last method defined
		def self.method_added(method_name)
			if method_name[0] == "_" && Phlex::HTML.instance_methods.include?(method_name) && instance_method(method_name).owner != Phlex::HTML
				raise NameError, "👋 Redefining the method `#{name}##{method_name}` is not a good idea."
			end

			super
		end
	end
end
