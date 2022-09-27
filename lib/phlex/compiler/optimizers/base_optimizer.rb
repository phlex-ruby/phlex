# frozen_string_literal: true

module Phlex
	class Compiler
		module Optimizers
			class BaseOptimizer
				def initialize(node, compiler:)
					@node = node
					@compiler = compiler
				end

				def call
					if standard_element?
						@node.extend(self.class::StandardElement)
					elsif void_element?
						@node.extend(self.class::VoidElement)
					else
						false
					end
				end

				private

				def standard_element?
					HTML::STANDARD_ELEMENTS[name] && !@compiler.redefined?(name)
				end

				def void_element?
					HTML::VOID_ELEMENTS[name] && !@compiler.redefined?(name)
				end
			end
		end
	end
end
