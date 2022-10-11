# frozen_string_literal: true

module Components
	class Markdown < Phlex::View
		class Render < Redcarpet::Render::HTML
			include Redcarpet::Render::SmartyPants

			def header(text, level)
				case level
				when 1
					Title.new.call { CGI.unescapeHTML(text) }
				else
					Heading.new.call { CGI.unescapeHTML(text) }
				end
			end

			def codespan(code)
				CodeSpan.new.call { code }
			end

			def block_code(code, language)
				CodeBlock.new(code.gsub(/(?:^|\G) {4}/m, "	"), syntax: language).call
			end

			def html_escape(input)
				input
			end
		end

		MARKDOWN = Redcarpet::Markdown.new(Render.new, filter_html: false, autolink: true, fenced_code_blocks: true, tables: true, highlight: true, escape_html: false)

		def initialize(content)
			@content = content
		end

		def template
			raw MARKDOWN.render(@content)
		end
	end
end
