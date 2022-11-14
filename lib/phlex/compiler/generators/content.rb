# frozen_string_literal: true

module Phlex
	class Compiler
		module Generators
			class Content
				def initialize(formatter, content:, mutating: false)
					@formatter = formatter
					@content = content
					@mutating = mutating
				end

				def call
					return if nil_value?
					return bare_string_value if bare_string_value?
					return symbol_value if symbol_value?
					return numeric_value if numeric_value?
					return variable_value if variable_value?

					unknown_value
				end

				private

				def nil_value?
					case @content
					in SyntaxTree::VarRef[value: SyntaxTree::Kw[value: "nil"]]
						true
					else
						false
					end
				end

				def bare_string_value?
					case @content
					in SyntaxTree::StringLiteral[parts: [SyntaxTree::TStringContent]]
						true
					else
						false
					end
				end

				def symbol_value?
					@content.is_a?(SyntaxTree::SymbolLiteral)
				end

				def numeric_value?
					@content.is_a?(SyntaxTree::Int) || @content.is_a?(SyntaxTree::FloatLiteral)
				end

				def variable_value?
					@content.is_a?(SyntaxTree::VarRef)
				end

				def bare_string_value
					@formatter.append do |f|
						f.text Hescape.escape_html(
							@content.parts.first.value
						)
					end
				end

				def symbol_value
					@formatter.append do |f|
						f.text Hescape.escape_html(
							@content.value.value
						)
					end
				end

				def numeric_value
					@formatter.append do |f|
						f.text Hescape.escape_html(
							@content.value
						)
					end
				end

				def variable_value
					@formatter.chain_append do |f|
						f.text "Hescape.escape_html("
						@content.format(f)
						f.text ")"
					end
				end

				def unknown_value
					@formatter.breakable(force: true)
					if @mutating
						@content.format(@formatter)
					else
						@formatter.text "yield_content {"
						@formatter.breakable(force: true)
						@content.format(@formatter)
						@formatter.breakable(force: true)
						@formatter.text "}"
					end
					@formatter.breakable(force: true)
				end
			end
		end
	end
end
