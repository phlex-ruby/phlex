# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Overrides::Symbol::Name
end

module Phlex::Helpers
	def tokens(...)
		Phlex::Helpers::TokenGenerator.new(self, ...).call
	end

	def classes(*tokens, **conditional_tokens)
		Phlex::Helpers::TokenGenerator.new(self, *tokens, namespace: :class, **conditional_tokens).call
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
