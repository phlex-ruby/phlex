# frozen_string_literal: true

module Phlex::Bucket
	def self.extended(mod)
		warn "🚨 [WARNING] Phlex::Bucket is experimental and may be removed from future versions of Phlex."
	end

	# When a bucket is included in a module, we need to load all of its components.
	def included(mod)
		constants.each { |c| mod.const_get(c) if autoload?(c) }
	end

	def method_missing(name, *args, **kwargs, &block)
		if constants.include?(name) && const_get(name) && methods.include?(name)
			public_send(name, *args, **kwargs, &block)
		else
			super
		end
	end

	def respond_to_missing?(name, include_private = false)
		constants.include?(name) && const_get(name) && methods.include?(name)
	end

	def const_added(name)
		return if autoload?(name)

		constant = const_get(name)

		if instance_methods.include?(name)
			raise NameError, "The instance method `#{name}' is already defined on `#{inspect}`."
		elsif methods.include?(name)
			raise NameError, "The method `#{name}' is already defined on `#{inspect}`."
		end

		constant.include(self)

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
