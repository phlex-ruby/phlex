# frozen_string_literal: true

module Components
	class Markdown < Phlex::Markdown
		def code(&content)
			render CodeSpan.new, &content
		end

		def code_block(code, language:)
			render CodeBlock.new(code.gsub(/(?:^|\G) {4}/m, "	"), syntax: language)
		end

		def h1(&content)
			render Title.new, &content
		end

		def h2(&content)
			render Heading.new, &content
		end
	end
end
