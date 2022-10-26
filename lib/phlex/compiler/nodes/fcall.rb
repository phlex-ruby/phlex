# frozen_string_literal: true

module Phlex::Compiler::Nodes
	class FCall < Base
		def name
			@node.value.value.to_sym
		end

		def arguments
			case @node.arguments
			in SyntaxTree::Args
				@node.arguments
			in SyntaxTree::ArgParen
				@node.arguments.arguments
			end
		end
	end
end
