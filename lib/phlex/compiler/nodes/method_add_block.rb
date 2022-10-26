# frozen_string_literal: true

module Phlex::Compiler::Nodes
	class MethodAddBlock < Base
		def name
			method_call.name
		end

		def arguments
			method_call.arguments
		end

		def method_call
			@method_call ||= case @node.call
			in SyntaxTree::FCall
				Phlex::Compiler::Nodes::FCall.new(@node.call)
			in SyntaxTree::Command
				Phlex::Compiler::Nodes::Command.new(@node.call)
			in SyntaxTree::Call
				Phlex::Compiler::Nodes::Call.new(@node.call)
			end
		end

		def content
			case @node.block
			in SyntaxTree::BraceBlock
				@node.block.statements
			in SyntaxTree::DoBlock
				@node.block.bodystmt.statements
			end
		end
	end
end
