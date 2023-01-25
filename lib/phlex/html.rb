# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex
	class HTML
		DOCTYPE = "<!DOCTYPE html>"

		STANDARD_ELEMENTS = {
			a: "a",
			abbr: "abbr",
			address: "address",
			article: "article",
			aside: "aside",
			b: "b",
			bdi: "bdi",
			bdo: "bdo",
			blockquote: "blockquote",
			body: "body",
			button: "button",
			caption: "caption",
			cite: "cite",
			code: "code",
			colgroup: "colgroup",
			data: "data",
			datalist: "datalist",
			dd: "dd",
			del: "del",
			details: "details",
			dfn: "dfn",
			dialog: "dialog",
			div: "div",
			dl: "dl",
			dt: "dt",
			em: "em",
			fieldset: "fieldset",
			figcaption: "figcaption",
			figure: "figure",
			footer: "footer",
			form: "form",
			g: "g",
			h1: "h1",
			h2: "h2",
			h3: "h3",
			h4: "h4",
			h5: "h5",
			h6: "h6",
			head: "head",
			header: "header",
			html: "html",
			i: "i",
			iframe: "iframe",
			ins: "ins",
			kbd: "kbd",
			label: "label",
			legend: "legend",
			li: "li",
			main: "main",
			map: "map",
			mark: "mark",
			menuitem: "menuitem",
			meter: "meter",
			nav: "nav",
			noscript: "noscript",
			object: "object",
			ol: "ol",
			optgroup: "optgroup",
			option: "option",
			output: "output",
			p: "p",
			path: "path",
			picture: "picture",
			pre: "pre",
			progress: "progress",
			q: "q",
			rp: "rp",
			rt: "rt",
			ruby: "ruby",
			s: "s",
			samp: "samp",
			script: "script",
			section: "section",
			select: "select",
			slot: "slot",
			small: "small",
			span: "span",
			strong: "strong",
			style: "style",
			sub: "sub",
			summary: "summary",
			sup: "sup",
			svg: "svg",
			table: "table",
			tbody: "tbody",
			td: "td",
			template_tag: "template",
			textarea: "textarea",
			tfoot: "tfoot",
			th: "th",
			thead: "thead",
			time: "time",
			title: "title",
			tr: "tr",
			u: "u",
			ul: "ul",
			video: "video",
			wbr: "wbr",
		}.freeze

		VOID_ELEMENTS = {
			area: "area",
			br: "br",
			embed: "embed",
			hr: "hr",
			img: "img",
			input: "input",
			link: "link",
			meta: "meta",
			param: "param",
			source: "source",
			track: "track",
			col: "col",
		}.freeze

		EVENT_ATTRIBUTES = %w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

		extend Elements
		include Helpers

		class << self
			attr_accessor :rendered_at_least_once

			def call(...)
				new(...).call
			end
			alias_method :render, :call

			def new(*args, **kwargs, &block)
				if block
					object = super(*args, **kwargs, &nil)
					object.instance_variable_set(:@_content_block, block)
					object
				else
					super
				end
			end
		end

		def call(buffer = +"", view_context: nil, parent: nil, &block)
			@_target = buffer
			@_view_context = view_context
			@_parent = parent

			block ||= @_content_block

			return buffer unless render?

			around_template do
				if block
					if DeferredRender === self
						__vanish__(self, &block)
						template
					else
						template do |*args|
							if args.length > 0
								yield_content_with_args(*args, &block)
							else
								yield_content(&block)
							end
						end
					end
				else
					template
				end
			end

			self.class.rendered_at_least_once = true

			buffer
		end

		def render(renderable, &block)
			case renderable
			when Phlex::HTML
				renderable.call(@_target, view_context: @_view_context, parent: self, &block)
			when Class
				if renderable < Phlex::HTML
					renderable.new.call(@_target, view_context: @_view_context, parent: self, &block)
				end
			else
				raise ArgumentError, "You can't render a #{renderable}."
			end

			nil
		end

		def format
			:html
		end

		STANDARD_ELEMENTS.each do |method_name, tag|
			register_element(method_name, tag: tag)
		end

		VOID_ELEMENTS.each do |method_name, tag|
			register_void_element(method_name, tag: tag)
		end

		def text(content)
			@_target << ERB::Util.html_escape(
				case content
					when String then content
					when Symbol then content.name
					when Integer then content.to_s
					else format_object(content) || content.to_s
				end
			)

			nil
		end

		def whitespace
			@_target << " "

			if block_given?
				yield
				@_target << " "
			end

			nil
		end

		def comment(&block)
			@_target << "<!-- "
			yield_content(&block)
			@_target << " -->"

			nil
		end

		def doctype
			@_target << DOCTYPE
			nil
		end

		def unsafe_raw(content = nil)
			return nil unless content

			@_target << content
		end

		def capture
			return unless block_given?

			original_buffer = @_target
			new_buffer = +""
			@_target = new_buffer

			yield

			new_buffer
		ensure
			@_target = original_buffer
		end

		# Like `capture` but the output is vanished into a BlackHole buffer.
		# Becuase the BlackHole does nothing with the output, this should be faster.
		private def __vanish__(*args)
			return unless block_given?

			original_buffer = @_target
			@_target = BlackHole

			yield(*args)
			nil
		ensure
			@_target = original_buffer
		end

		# Default render predicate can be overridden to prevent rendering
		private def render?
			true
		end

		private def format_object(object)
			case object
			when Float
				object.to_s
			end
		end

		private def around_template
			before_template
			yield
			after_template
		end

		private def before_template
			nil
		end

		private def after_template
			nil
		end

		private def yield_content
			return unless block_given?

			original_length = @_target.length
			content = yield(self)
			unchanged = (original_length == @_target.length)

			if unchanged
				case content
				when String
					@_target << ERB::Util.html_escape(content)
				when Symbol
					@_target << ERB::Util.html_escape(content.name)
				when Integer
					@_target << ERB::Util.html_escape(content.to_s)
				else
					if (formatted_object = format_object(content))
						@_target << ERB::Util.html_escape(formatted_object)
					end
				end
			end

			nil
		end

		private def yield_content_with_args(*args)
			return unless block_given?

			original_length = @_target.length
			content = yield(*args)
			unchanged = (original_length == @_target.length)

			if unchanged
				case content
				when String
					@_target << ERB::Util.html_escape(content)
				when Symbol
					@_target << ERB::Util.html_escape(content.name)
				when Integer, Float
					@_target << ERB::Util.html_escape(content.to_s)
				else
					if (formatted_object = format_object(content))
						@_target << ERB::Util.html_escape(formatted_object)
					end
				end
			end

			nil
		end

		private def __attributes__(**attributes)
			if attributes[:href]&.start_with?(/\s*javascript/)
				attributes[:href] = attributes[:href].sub(/^\s*(javascript:)+/, "")
			end

			buffer = +""
			__build_attributes__(attributes, buffer: buffer)

			unless self.class.rendered_at_least_once
				Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
			end

			buffer
		end

		private def __build_attributes__(attributes, buffer:)
			attributes.each do |k, v|
				next unless v

				name = case k
					when String then k
					when Symbol then k.name.tr("_", "-")
					else k.to_s
				end

				# Detect unsafe attribute names. Attribute names are considered unsafe if they match an event attribute or include unsafe characters.
				if HTML::EVENT_ATTRIBUTES[name] || name.match?(/[<>&"']/)
					raise ArgumentError, "Unsafe attribute name detected: #{k}."
				end

				case v
				when true
					buffer << " " << name
				when String
					buffer << " " << name << '="' << ERB::Util.html_escape(v) << '"'
				when Symbol
					buffer << " " << name << '="' << ERB::Util.html_escape(v.name) << '"'
				when Hash
					__build_attributes__(
						v.transform_keys { |subkey|
							case subkey
								when Symbol then"#{k}-#{subkey.name.tr('_', '-')}"
								else "#{k}-#{subkey}"
							end
						}, buffer: buffer
					)
				else
					buffer << " " << name << '="' << ERB::Util.html_escape(v.to_s) << '"'
				end
			end

			buffer
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
