# frozen_string_literal: true

module Phlex
	class Compiler
		def initialize(component)
			@component = component
		end

		def inspect
			"#{self.class.name} for #{@component.name} component class"
		end

		def call
			Visitors::File.new(self).visit(tree)
		end

		def redefined?(method_name)
			prototype = @component.allocate

			@component.instance_method(method_name).bind(prototype) !=
				Phlex::Component.instance_method(method_name).bind(prototype)
		end

		def redefine(method)
			@component.class_eval(method)
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
			::Module.const_source_location(@component.name)
		end
	end
end
