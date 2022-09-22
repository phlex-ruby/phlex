# frozen_string_literal: true

module Phlex
	class Compiler
		module Visitors
			class ComponentMethod < Base
				def optimized_something?
					!!@optimized_something
				end

				visit_method def visit_vcall(node)
					name = node.value.value.to_sym

					if HTML::STANDARD_ELEMENTS[name] && !@compiler.redefined?(name)
						@optimized_something = true
						node.extend(Optimizers::VCall::StandardElement)
					elsif HTML::VOID_ELEMENTS[name] && !@compiler.redefined?(name)
						@optimized_something = true
						node.extend(Optimizers::VCall::VoidElement)
					end

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
