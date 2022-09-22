# frozen_string_literal: true

module Fixtures
	module Compilation
		module VCall
			class WithStandardElement < Phlex::Component
				def template
					div
				end
			end

			class WithVoidElement < Phlex::Component
				def template
					img
				end
			end

			class WithAnotherMethodCall < Phlex::Component
				def template
					article
					some_other_method
					article
				end
			end

			class WithRedefinedTagMethod < Phlex::Component
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
