# frozen_string_literal: true

module Fixtures
	module VoidElement
		class WithParens < Phlex::HTML
			def template
				img()
			end
		end

		class WithoutParens < Phlex::HTML
			def template
				img
			end
		end

		module WithAttributes
			class WithParens < Phlex::HTML
				def template
					img(class: "a b c")
				end
			end

			class WithoutParens < Phlex::HTML
				def template
					img class: "a b c"
				end
			end
		end
	end
end
