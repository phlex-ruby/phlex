# frozen_string_literal: true

module Components
	class Heading < Phlex::View
		def template(&block)
			h2(class: "text-xl font-bold mt-10 mb-5", &block)
		end
	end
end
