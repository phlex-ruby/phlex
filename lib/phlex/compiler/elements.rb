# frozen_string_literal: true

module Phlex::Compiler::Elements
	module VCall
		def format(formatter)
			Phlex::Compiler::Generators::Element.new(
				Phlex::Compiler::Nodes::VCall.new(self),
				formatter: formatter
			).call
		end
	end

	module FCall
		def format(formatter)
			Phlex::Compiler::Generators::Element.new(
				Phlex::Compiler::Nodes::FCall.new(self),
				formatter: formatter
			).call
		end
	end

	module Command
		def format(formatter)
			Phlex::Compiler::Generators::Element.new(
				Phlex::Compiler::Nodes::Command.new(self),
				formatter: formatter
			).call
		end
	end

	module MutatingMethodAddBlock
		def format(formatter)
			Phlex::Compiler::Generators::Element.new(
				Phlex::Compiler::Nodes::MethodAddBlock.new(self),
				formatter: formatter,
				mutating: true
			).call
		end
	end

	module MethodAddBlock
		def format(formatter)
			Phlex::Compiler::Generators::Element.new(
				Phlex::Compiler::Nodes::MethodAddBlock.new(self),
				formatter: formatter
			).call
		end
	end
end
