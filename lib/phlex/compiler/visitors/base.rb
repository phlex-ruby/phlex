# frozen_string_literal: true

module Phlex
	class Compiler
		module Visitors
			class Base < SyntaxTree::Visitor
				def initialize(compiler = nil)
					@compiler = compiler
				end

				private

				def format(node)
					Formatter.format("", node)
				end
			end
		end
	end
end
