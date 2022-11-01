# frozen_string_literal: true

module Phlex::Helpers
	def tokens(*tokens, **conditional_tokens)
		conditional_tokens.each do |condition, token|
			case condition
			when Symbol then next unless send(condition)
			when Proc then next unless condition.call
			else raise ArgumentError,
				"The class condition must be a Symbol or a Proc."
			end

			case token
			when Symbol then tokens << token.name
			when String then tokens << token
			when Array then tokens.concat(token)
			else raise ArgumentError,
				"Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
			end
		end

		tokens.compact.join(" ")
	end

	def classes(*tokens, **conditional_tokens)
		tokens = self.tokens(*tokens, **conditional_tokens)

		if tokens.empty?
			{}
		else
			{ class: tokens }
		end
	end
end
