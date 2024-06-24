# frozen_string_literal: true

module Phlex::Helpers
	private

	# Tokens
	# @return [String]
	# @example With Proc conditions
	# 	tokens(
	# 		-> { true } => "a",
	# 		-> { false } => "b"
	# 	)
	# @example With method conditions
	# 	tokens(
	# 		active?: "active"
	# 	)
	# @example With else condition
	# 	tokens(
	# 		active?: { then: "active", else: "inactive" }
	# 	)
	def tokens(*tokens, **conditional_tokens)
		conditional_tokens.each do |condition, token|
			truthy = case condition
				when Symbol then __send__(condition)
				when Proc then condition.call
				else raise ArgumentError.new("The class condition must be a Symbol or a Proc.")
			end

			if truthy
				case token
					when Hash then __append_token__(tokens, token[:then])
					else __append_token__(tokens, token)
				end
			else
				case token
					when Hash then __append_token__(tokens, token[:else])
				end
			end
		end

		tokens = tokens.select(&:itself).join(" ")
		tokens.strip!
		tokens.gsub!(/\s+/, " ")
		tokens
	end

	# @api private
	def __append_token__(tokens, token)
		case token
			when nil then nil
			when String then tokens << token
			when Symbol then tokens << token.name
			when Array then tokens.concat(token)
			else raise ArgumentError.new("Conditional classes must be Symbols, Strings, or Arrays of Symbols or Strings.")
		end
	end

	# Like {#tokens} but returns a {Hash} where the tokens are the value for `:class`.
	# @return [Hash]
	def classes(*tokens, **conditional_tokens)
		tokens = self.tokens(*tokens, **conditional_tokens)

		if tokens.empty?
			{}
		else
			{ class: tokens }
		end
	end

	# @return [Hash]
	def mix(*args)
		args.each_with_object({}) do |object, result|
			result.merge!(object) do |_key, old, new|
				next new if old.nil?

				case new
				when Hash
					old.is_a?(Hash) ? mix(old, new) : new
				when Array
					case old
					when Array then old + new
					when Set then old.to_a + new
					when Hash then new
					else
						[old] + new
					end
				when Set
					case old
					when Set then old + new
					when Array then old + new.to_a
					when Hash then new
					else
						new + [old]
					end
				when String
					old.is_a?(String) ? "#{old} #{new}" : old + old.class[new]
				when nil
					old
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
