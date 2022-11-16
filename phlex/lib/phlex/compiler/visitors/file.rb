# frozen_string_literal: true

module Phlex::Compiler::Visitors
	class File < Base
		def initialize(compiler)
			@scope = []
			super
		end

		visit_method def visit_class(node)
			@scope.push(node)

			if node.location.start_line == @compiler.line
				@compiler.scope = @scope
				View.new(@compiler).visit_all(node.child_nodes)
			else
				super
			end

			@scope.pop
		end

		visit_method def visit_module(node)
			@scope.push(node)
			super
			@scope.pop
		end
	end
end
