# frozen_string_literal: true

module Phlex::Compiler::Nodes
	class Base
		def initialize(node)
			@node = node
		end

		attr_accessor :node

		def arguments
			nil
		end

		def content
			nil
		end
	end
end
