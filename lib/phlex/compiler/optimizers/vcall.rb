# frozen_string_literal: true

module Phlex
	class Compiler
		module Optimizers
			module VCall
				module StandardElement
					def format(formatter)
						Generators::StandardElement.new(formatter,
							method_name: value.value.to_sym).call
					end
				end

				module VoidElement
					def format(formatter)
						Generators::VoidElement.new(formatter,
							method_name: value.value.to_sym).call
					end
				end
			end
		end
	end
end
