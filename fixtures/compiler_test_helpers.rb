# frozen_string_literal: true

module CompilerTestHelpers
	# @return Array
	def compile(view)
		@compiler = Phlex::Compiler.new(view)
		output = []

		mock(@compiler) do |m|
			m.before(:redefine) { output << _1 }
		end

		@compiler.call

		output.map! do |method|
			Phlex::Compiler::Formatter.format("", SyntaxTree.parse(method))
		end
	end
end
