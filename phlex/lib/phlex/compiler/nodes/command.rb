# frozen_string_literal: true

module Phlex::Compiler::Nodes
	class Command < Base
		def name
			@node.message.value.to_sym
		end

		def arguments
			@node.arguments
		end
	end
end
