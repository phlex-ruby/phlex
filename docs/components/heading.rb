# frozen_string_literal: true

module Components
	class Heading < Phlex::View
		def template(&)
			h2(class: "text-2xl font-semibold mt-10 mb-5") { raw(&) }
		end
	end
end
