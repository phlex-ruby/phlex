# frozen_string_literal: true

module Phlex::Helpers
	class TokenGenerator
		def initialize(context, *tokens, namespace: nil, **conditional_tokens)
			raise ArgumentError, "Tokens should not be passed as an array" if tokens[0].is_a?(Array)

			@tokens = tokens
			@context = context
			@conditional_tokens = conditional_tokens
			@namespace = namespace
		end

		# Converts non-hash token values into a :then/:else hash structure
		def self.normalize_conditional_tokens(tokens)
			{}.tap do |validated_tokens|
				tokens.each do |condition, value|
					validated_tokens[condition] = begin
						case value
						when Hash then validate_hash!(value)
						else { then: value }
						end
					end
				end
			end
		end

		# Ensures a hash token value structure has at minimum a :then entry
		def self.validate_hash!(hash)
			raise ArgumentError, "Token hash mush have a :then key" unless hash.key?(:then)

			hash
		end

		def call
			return {} if @namespace && all_tokens.empty?
			return { @namespace.to_sym => all_tokens_value } if @namespace

			all_tokens_value
		end

		private

		# Joins all_tokens array with <space> separator
		def all_tokens_value
			all_tokens.join(" ")
		end

		# Returns array of tokens and conditional tokens that passed checks
		def all_tokens
			@all_tokens ||= [
				*@tokens,
				*normalized_conditional_tokens.map do |symbol_or_proc, token_hash|
					result = case symbol_or_proc
						when Symbol then @context.send(symbol_or_proc)
						when Proc then symbol_or_proc.call
						else raise ArgumentError,
							"The class condition must be a Symbol or a Proc."
					end

					result ? token_hash[:then] : token_hash[:else]
				end
			].compact.uniq
		end

		# Memoized hash of normalized conditional tokens
		def normalized_conditional_tokens
			@normalized_conditional_tokens ||= TokenGenerator.normalize_conditional_tokens(@conditional_tokens)
		end
	end
end
