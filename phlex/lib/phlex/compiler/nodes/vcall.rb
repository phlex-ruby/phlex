# frozen_string_literal: true

module Phlex::Compiler::Nodes
	class VCall < Base
		def name
			@node.value.value.to_sym
		end
	end
end
