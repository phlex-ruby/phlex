# frozen_string_literal: true

module Phlex
	class Compiler
		module Visitors
			class ComponentMethod < Base
				def optimized_something?
					!!@optimized_something
				end

				visit_method def visit_vcall(node)
					@optimized_something = Optimizers::VCall.new(node,
						compiler: @compiler).call

					super
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
