# frozen_string_literal: true

module Components
	class CodeSpan < Phlex::HTML
		def template(&block)
			code(class: "bg-stone-50 inline-block font-medium rounded border px-1 -mt-1", &block)
		end
	end
end
