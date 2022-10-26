# frozen_string_literal: true

module Components
	class Callout < Phlex::View
		def template(&)
			div(class: "rounded bg-orange-50 text-sm p-5 border border-orange-100", &)
		end
	end
end
