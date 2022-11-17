# frozen_string_literal: true

# A mixin for visitors that stops them from visiting other scopes.

module Phlex::Compiler::Visitors::StableScope
	def visit_class(node)
		nil
	end

	def visit_module(node)
		nil
	end

	def visit_brace_block(node)
		nil
	end

	def visit_do_block(node)
		nil
	end

	def visit_method_add_block(node)
		node = Phlex::Compiler::Nodes::MethodAddBlock.new(node)
		if node.method_call.name == :render
			visit(node.content)
		end
	end
end
