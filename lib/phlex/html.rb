# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex
	module HTML
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

		def register_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(content = nil, **attributes, &block)
					if content
						raise ArgumentError, %(👋 You can no longer pass content to #{element} as a positional argument.\n Instead, you can pass it as a block, e.g. #{element} { "Hello" })
					end

          if attributes.length > 0
            if block_given?
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << ">"
              yield_content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << "></#{tag}>"
            end
          else
            if block_given?
              @_target << "<#{tag}>"
              yield_content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}></#{tag}>"
            end
          end

          nil
        end
			RUBY
		end

		def register_void_element(element, tag: element.name.tr("_", "-"))
			class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(**attributes)
          if attributes.length > 0
            @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << ">"
          else
            @_target << "<#{tag}>"
          end

          nil
        end
			RUBY
		end
	end
end
