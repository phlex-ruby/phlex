# frozen_string_literal: true

module Phlex
	class Compiler
		module Generators
			class Element
				def initialize(node, formatter:, mutating: false)
					@node = node
					@formatter = formatter
					@mutating = mutating
				end

				def call
					@formatter.append do |f|
						f.text "<"
						f.text tag
					end

					if @node.arguments&.parts&.any?
						@formatter.chain_append do |f|
							f.text "process_attributes("
							@node.arguments.format(@formatter)
							f.text ")"
						end
					end

					@formatter.append do |f|
						f.text ">"
					end

					return if void?

					case @node.content
					in SyntaxTree::Statements[body: [c]]
						Content.new(@formatter, content: c, mutating: @mutating).call
					in nil
						nil
					else
						@node.content.format(@formatter)
					end

					@formatter.append do |f|
						f.text "</"
						f.text tag
						f.text ">"
					end
				end

				private

				def tag
					HTML::STANDARD_ELEMENTS[@node.name] || HTML::VOID_ELEMENTS[@node.name]
				end

				def void?
					HTML::VOID_ELEMENTS.key?(@node.name)
				end
			end
		end
	end
end
