# frozen_string_literal: true

module Phlex
	class Compiler
		def initialize(view)
			@view = view
		end

		def inspect
			"#{self.class.name} for #{@view.name} view class"
		end

		def call
			Visitors::File.new(self).visit(tree)
		end

		def redefined?(method_name)
			prototype = @view.allocate

			@view.instance_method(method_name).bind(prototype) !=
				Phlex::View.instance_method(method_name).bind(prototype)
		end

		def redefine(method)
			@view.class_eval(method)
		end

		def line
			location[1]
		end

		private

		def tree
			@tree ||= SyntaxTree.parse(source)
		end

		def source
			SyntaxTree.read(file)
		end

		def file
			location[0]
		end

		def location
			::Module.const_source_location(@view.name)
		end
	end
end
