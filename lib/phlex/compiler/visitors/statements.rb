# frozen_string_literal: true

module Phlex::Compiler::Visitors
	class Statements < Base
		MUTATING_METHODS = [:raw, :whitespace, :comment, :text, :doctype]

		include StableScope

		def mutating?
			!!@mutating
		end

		visit_method def visit_vcall(node)
			check Phlex::Compiler::Nodes::VCall.new(node)
		end

		visit_method def visit_fcall(node)
			check Phlex::Compiler::Nodes::FCall.new(node)
		end

		visit_method def visit_command(node)
			check Phlex::Compiler::Nodes::Command.new(node)
		end

		visit_method def visit_method_add_block(node)
			check Phlex::Compiler::Nodes::MethodAddBlock.new(node)
		end

		private

		def check(node)
			@mutating = true if @compiler.tag_method?(node.name)
			@mutating = true if MUTATING_METHODS.include?(node.name) && !@compiler.redefined?(node.name)
		end
	end
end
