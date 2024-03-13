# frozen_string_literal: true

module Phlex::Bucket
	def const_added(name)
		constant = const_get(name)

		if instance_methods.include?(name)
			raise NameError, "method #{name} is already defined"
		else
			warn "Phlex::Bucket is experimental and may be removed from future versions of Phlex."
		end

		if Class === constant && constant < Phlex::SGML
			define_method(name) do |*args, **kwargs, &block|
				render(constant.new(*args, **kwargs), &block)
			end

			define_singleton_method(name) do |*args, **kwargs, &block|
				Fiber[:__phlex_component__].instance_exec do
					render(constant.new(*args, **kwargs), &block)
				end
			end
		end
	end
end
