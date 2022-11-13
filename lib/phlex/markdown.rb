# frozen_string_literal: true

require "markly"

module Phlex
	class Markdown < Phlex::HTML
		def initialize(content)
			@content = content
		end

		def template
			visit(doc)
		end

		private

		def doc
			Markly.parse(@content)
		end

		def visit(node)
			return if node.nil?

			case node.type
			in :document | :softbreak
				visit_children(node)
			in :text
				text(node.string_content)
			in :header
				case node.header_level
					in 1 then h1 { visit_children(node) }
					in 2 then h2 { visit_children(node) }
					in 3 then h3 { visit_children(node) }
					in 4 then h4 { visit_children(node) }
					in 5 then h5 { visit_children(node) }
					in 6 then h6 { visit_children(node) }
				end
			in :paragraph
				p { visit_children(node) }
			in :link
				a(href: node.url) { visit_children(node) }
			in :emph
				em { visit_children(node) }
			in :strong
				strong { visit_children(node) }
			in :list
				case node.list_type
					in :ordered_list then ol { visit_children(node) }
					in :bullet_list then ul { visit_children(node) }
				end
			in :list_item
				li { visit_children(node) }
			in :code
				whitespace { code { text(node.string_content) } }
			in :code_block
				code_block(node.string_content, language: node.fence_info) do |**attributes|
					pre(**attributes) { text(node.string_content) }
				end
			end
		end

		def code_block(code, language:)
			yield
		end

		def visit_children(node)
			node.each { |c| visit(c) }
		end
	end
end
