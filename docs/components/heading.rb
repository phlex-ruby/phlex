# frozen_string_literal: true

module Components
	class Heading < Phlex::HTML
		def template(&block)
			h2(class: "text-2xl font-semibold mt-10 mb-5", &block)
		end
	end
end
