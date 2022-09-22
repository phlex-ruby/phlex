# frozen_string_literal: true

module Components
	class Markdown < Phlex::Component
		class Render < Redcarpet::Render::HTML
			def header(text, level)
				case level
				when 1
					Title.new.call { text }
				else
					Heading.new.call { text }
				end
			end
		end

		MARKDOWN = Redcarpet::Markdown.new(Render.new, autolink: true, tables: true)

		def initialize(content)
			@content = content
		end

		def template
			raw MARKDOWN.render(@content)
		end
	end
end
