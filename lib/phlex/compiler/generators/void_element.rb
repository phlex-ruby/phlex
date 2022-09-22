# frozen_string_literal: true

module Phlex
	class Compiler
		module Generators
			class VoidElement
				def initialize(formatter, method_name:, arguments: nil)
					@formatter = formatter
					@method_name = method_name
					@arguments = arguments
				end

				def call
					@formatter.append do |f|
						f.text "<"
						f.text tag
						f.text " />"
					end
				end

				private

				def tag
					HTML::VOID_ELEMENTS[@method_name]
				end
			end
		end
	end
end
