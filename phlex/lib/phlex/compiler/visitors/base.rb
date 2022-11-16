# frozen_string_literal: true

module Phlex::Compiler::Visitors
	class Base < SyntaxTree::Visitor
		def initialize(compiler = nil)
			@compiler = compiler
		end

		private

		def format(node)
			Phlex::Compiler::Formatter.format("", node)
		end
	end
end
