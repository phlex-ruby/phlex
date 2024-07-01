# frozen_string_literal: true

module Phlex::Helpers
	private

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

	def grab(**bindings)
		if bindings.size > 1
			bindings.values
		else
			bindings.values.first
		end
	end
end
