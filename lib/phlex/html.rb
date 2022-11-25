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
		end

		def call(buffer = +"", view_context: nil, parent: nil, &block)
			return buffer unless render?

			raise "The same view instance shouldn't be rendered twice" if rendered?

			@_rendered = true
			@_target = buffer
			@_view_context = view_context
			@_parent = parent

			around_template { template { yield_content(&block) } }

			self.class.rendered_at_least_once ||= true

			buffer
		end

		def render(renderable, *args, **kwargs, &block)
			if renderable.is_a?(Phlex::HTML)
				renderable.call(@_target, view_context: @_view_context, parent: self, &block)
			elsif renderable.is_a?(Class) && renderable < Phlex::HTML
				raise ArgumentError, "You tried to render the Phlex view class: #{renderable.name} but you probably meant to render an instance of that class instead."
			else
				raise ArgumentError, "You can't render a #{renderable}."
			end

			nil
		end

		def format
			:html
		end

		def rendered?
			@_rendered ||= false
		end

		def render?
			true
		end

		STANDARD_ELEMENTS.each do |method_name, tag|
			register_element(method_name, tag: tag)
		end

		VOID_ELEMENTS.each do |method_name, tag|
			register_void_element(method_name, tag: tag)
		end

		def text(content)
			case content
			when String
				@_target << CGI.escape_html(content)
			when Symbol
				@_target << CGI.escape_html(content.name)
			when Integer, Float
				@_target << CGI.escape_html(content.to_s)
			end

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

		def unsafe_raw(content = nil, &block)
			@_target << (content || instance_exec(&block))
			nil
		end

		def capture(&block)
			return unless block_given?

			original_buffer = @_target
			new_buffer = +""
			@_target = new_buffer

			yield

			@_target = original_buffer

			new_buffer
		end

		private

		def around_template
			before_template
			yield
			after_template
		end

		def before_template
			nil
		end

		def after_template
			nil
		end

		def yield_content(&block)
			return unless block_given?

			original_length = @_target.length
			content = yield(self)
			unchanged = (original_length == @_target.length)

			if unchanged
				case content
				when String
					@_target << CGI.escape_html(content)
				when Symbol
					@_target << CGI.escape_html(content.name)
				when Integer, Float
					@_target << CGI.escape_html(content.to_s)
				end
			end

			nil
		end

		def _attributes(**attributes)
			if attributes[:href]&.start_with?(/\s*javascript/)
				attributes[:href] = attributes[:href].sub(/^\s*(javascript:)+/, "")
			end

			buffer = +""
			_build_attributes(attributes, buffer: buffer)

			unless self.class.rendered_at_least_once
				Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
			end

			buffer
		end

		def _build_attributes(attributes, buffer:)
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
					buffer << " " << name << '="' << CGI.escape_html(v) << '"'
				when Symbol
					buffer << " " << name << '="' << CGI.escape_html(v.name) << '"'
				when Hash
					_build_attributes(v.transform_keys { "#{k}-#{_1.name.tr('_', '-')}" }, buffer: buffer)
				else
					buffer << " " << name << '="' << CGI.escape_html(v.to_s) << '"'
				end
			end

			buffer
		end
	end
end
