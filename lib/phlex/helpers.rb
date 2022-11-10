# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

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

	def mix(*args)
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
