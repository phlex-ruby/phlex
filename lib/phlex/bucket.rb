# frozen_string_literal: true

module Phlex::Bucket
	module Proxy
		def method_missing(name, *args, **kwargs, &block)
			return super unless self.class.constants.include?(name)
			constant = self.class.const_get(name)

			if methods.include?(name)
				public_send(name, *args, **kwargs, &block)
			else
				super
			end
		end
	end

	def self.extended(mod)
		warn "🚨 [WARNING] Phlex::Bucket is experimental and may be removed from future versions of Phlex."
		mod.include(Proxy)
	end

	def method_missing(name, *args, **kwargs, &block)
		return super unless constants.include?(name)
		constant = const_get(name)

		if methods.include?(name)
			public_send(name, *args, **kwargs, &block)
		else
			super
		end
	end

	def respond_to_missing?(name, include_private = false)
		autoload?(name) || super
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
