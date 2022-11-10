# frozen_string_literal: true

class Phlex::Compiler
	class Optimizer
		def initialize(node, compiler:)
			@node = node
			@compiler = compiler
		end

		def call
			return optimize_element if optimize_element?

			false
		end

		private

		def optimize_element
			case @node
			in Nodes::VCall
				@node.node.extend(Phlex::Compiler::Elements::VCall)
			in Nodes::FCall
				@node.node.extend(Phlex::Compiler::Elements::FCall)
			in Nodes::Command
				@node.node.extend(Phlex::Compiler::Elements::Command)
			in Nodes::MethodAddBlock
				optimize_add_method_block_element
			end

			true
		end

		def optimize_add_method_block_element
			visitor = Phlex::Compiler::Visitors::Statements.new(@compiler)
			visitor.visit(@node.content)

			if visitor.mutating?
				@node.node.extend(Phlex::Compiler::Elements::MutatingMethodAddBlock)
			else
				@node.node.extend(Phlex::Compiler::Elements::MethodAddBlock)
			end

			Phlex::Compiler::Visitors::ViewMethod.new(@compiler).visit(@node.content)
		end

		def optimize_element?
			element? && !redefined?
		end

		def element?
			standard_element? || void_element?
		end

		def redefined?
			@compiler.redefined?(@node.name)
		end

		def standard_element?
			Phlex::View::STANDARD_ELEMENTS.key?(@node.name)
		end

		def void_element?
			Phlex::View::VOID_ELEMENTS.key?(@node.name)
		end
	end
end
