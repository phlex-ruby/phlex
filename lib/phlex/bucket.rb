# frozen_string_literal: true

module Phlex::Bucket
	def const_added(name)
		constant = const_get(name)

		return if instance_methods.include?(name)

		if Class === constant && constant < Phlex::SGML
			define_method(name) do |*args, **kwargs, &block|
				render constant.new(*args, **kwargs, &block)
			end
		end
	end
end
