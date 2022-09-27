# frozen_string_literal: true

module Fixtures
	module Compilation
		module VCall
			class WithStandardElement < Phlex::View
				def template
					div
				end
			end

			class WithVoidElement < Phlex::View
				def template
					img
				end
			end

			class WithAnotherMethodCall < Phlex::View
				def template
					article
					some_other_method
					article
				end
			end

			class WithRedefinedTagMethod < Phlex::View
				def template
					title
					article
				end

				def title
					h1
				end
			end
		end
	end
end
