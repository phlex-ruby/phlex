# frozen_string_literal: true

module Phlex::Helpers
	private

	# @return [Hash]
	def mix(*args)
		args.each_with_object({}) do |object, result|
			result.merge!(object) do |_key, old, new|
				case [old, new]
				in [Array, Array] | [Set, Set]
					old + new
				in [Array, Set]
					old + new.to_a
				in [Array, String]
					old + [new]
				in [Hash, Hash]
					mix(old, new)
				in [Set, Array]
					old.to_a + new
				in [Set, String]
					old.to_a + [new]
				in [String, Array]
					[old] + new
				in [String, Set]
					[old] + new.to_a
				in [String, String]
					"#{old} #{new}"
				else
					new.nil? ? old : new
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
