# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex::Helpers
	private def tokens(*tokens, **conditional_tokens)
		conditional_tokens.each do |condition, token|
			truthy = case condition
				when Symbol then send(condition)
				when Proc then condition.call
				else raise ArgumentError, "The class condition must be a Symbol or a Proc."
			end

			if truthy
				case token
					when Hash then _append_token(tokens, token[:then])
					else _append_token(tokens, token)
				end
			else
				case token
					when Hash then _append_token(tokens, token[:else])
				end
			end
		end

		tokens.join(" ")
	end

	private def _append_token(tokens, token)
		case token
			when nil then nil
			when String then tokens << token
			when Symbol then tokens << token.name
			when Array then tokens.concat(token)
			else raise ArgumentError,
				"Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings."
		end
	end

	private def classes(*tokens, **conditional_tokens)
		tokens = self.tokens(*tokens, **conditional_tokens)

		if tokens.empty?
			{}
		else
			{ class: tokens }
		end
	end

	private def mix(*args)
		args.each_with_object({}) do |object, result|
			result.merge!(object) do |_key, old, new|
				case new
				when Hash
					old.is_a?(Hash) ? mix(old, new) : new
				when Array
					old.is_a?(Array) ? (old + new) : new
				when String
					old.is_a?(String) ? "#{old} #{new}" : new
				else
					new
				end
			end

			result.transform_keys! do |key|
				key.end_with?("!") ? key.name.chop.to_sym : key
			end
		end
	end
end
