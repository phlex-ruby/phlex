module Phlex
	# @abstract Subclass and define {#template} to create an HTML component class.
	module HtmlRenderable
		include Renderable

		def self.included(including_class)
			super

			including_class.extend(ClassMethods)
			including_class.extend(Phlex::Elements)

			# This should be extended after all method definitions
			including_class.extend(ElementClobberingGuard)
		end

		# A list of HTML attributes that have the potential to execute unsafe JavaScript.
		EVENT_ATTRIBUTES = %w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

		UNBUFFERED_MUTEX = Mutex.new

		module ClassMethods
			include Phlex::Renderable::ClassMethods

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

		include Phlex::Helpers, Phlex::HTML::VoidElements, Phlex::HTML::StandardElements

		# Output an HTML doctype.
		def doctype
			@_context.target << "<!DOCTYPE html>"
			nil
		end

		# Outputs an `<svg>` tag
		# @return [nil]
		# @see https://developer.mozilla.org/docs/Web/SVG/Element/svg
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
	end
end
