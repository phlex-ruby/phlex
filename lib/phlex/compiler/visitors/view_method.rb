# frozen_string_literal: true

module Phlex::Compiler::Visitors
	class ViewMethod < Base
		include StableScope

		def optimized_something?
			!!@optimized_something
		end

		visit_method def visit_method_add_block(node)
			return super if node.call.is_a?(SyntaxTree::Call)

			optimizer = Phlex::Compiler::Optimizer.new(
				Phlex::Compiler::Nodes::MethodAddBlock.new(node),
				compiler: @compiler
			)

			if optimizer.call
				@optimized_something = true
			end

			super
		end

		visit_method def visit_vcall(node)
			optimizer = Phlex::Compiler::Optimizer.new(
				Phlex::Compiler::Nodes::VCall.new(node),
				compiler: @compiler
			)

			if optimizer.call
				@optimized_something = true
			end
		end

		visit_method def visit_fcall(node)
			optimizer = Phlex::Compiler::Optimizer.new(
				Phlex::Compiler::Nodes::FCall.new(node),
				compiler: @compiler
			)

			if optimizer.call
				@optimized_something = true
			end
		end

		visit_method def visit_command(node)
			optimizer = Phlex::Compiler::Optimizer.new(
				Phlex::Compiler::Nodes::Command.new(node),
				compiler: @compiler
			)

			if optimizer.call
				@optimized_something = true
			end
		end
	end
end
