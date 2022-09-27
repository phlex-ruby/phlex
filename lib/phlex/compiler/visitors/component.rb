# frozen_string_literal: true

module Phlex
	class Compiler
		module Visitors
			class Component < BaseVisitor
				visit_method def visit_def(node)
					visitor = Visitors::ComponentMethod.new(@compiler)
					visitor.visit_all(node.child_nodes)

					if visitor.optimized_something?
						@compiler.redefine(
							format(node)
						)
					end
				end

				visit_method def visit_class(node)
					nil
				end

				visit_method def visit_module(node)
					nil
				end
			end
		end
	end
end
