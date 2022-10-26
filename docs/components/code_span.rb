# frozen_string_literal: true

module Components
	class CodeSpan < Phlex::View
		def template(&)
			code(class: "bg-stone-50 inline-block font-medium rounded border px-1 -mt-1", &)
		end
	end
end
