# frozen_string_literal: true

module Phlex::Compiler::Visitors
	class View < Base
		include StableScope

		visit_method def visit_def(node)
			visitor = ViewMethod.new(@compiler)
			visitor.visit_all(node.child_nodes)

			if visitor.optimized_something?
				@compiler.redefine(
					format(node),
					line: node.location.start_line
				)
			end
		end
	end
end
