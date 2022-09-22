# frozen_string_literal: true

module Phlex
	class Compiler
		module Generators
			class StandardElement
				def initialize(formatter, method_name:, arguments: nil)
					@formatter = formatter
					@method_name = method_name
				end

				def call
					@formatter.append do |f|
						f.text "<"
						f.text tag
						f.text ">"

						f.text "</"
						f.text tag
						f.text ">"
					end
				end

				def tag
					HTML::STANDARD_ELEMENTS[@method_name]
				end
			end
		end
	end
end
