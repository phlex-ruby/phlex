# frozen_string_literal: true

module Phlex::Kit
	def self.extended(mod)
		warn "⚠️ [WARNING] Phlex::Kit is experimental and may be removed from future versions of Phlex."

		mod.define_method(:respond_to_missing?) do |name, _include_private = false|
			if name[0] == name[0].upcase && mod.constants.include?(name) && mod.const_get(name) && methods.include?(name)
				true
			else
				super
			end
		end

		mod.define_method(:method_missing) do |name, *args, **kwargs, &block|
			if name[0] == name[0].upcase && mod.constants.include?(name) && mod.const_get(name) && methods.include?(name)
				public_send(name, *args, **kwargs, &block)
			else
				super
			end
		end

		super
	end

	def method_missing(name, *args, **kwargs, &block)
		if name[0] == name[0].upcase && constants.include?(name) && const_get(name) && methods.include?(name)
			public_send(name, *args, **kwargs, &block)
		else
			super
		end
	end

	def respond_to_missing?(name, include_private = false)
		if name[0] == name[0].upcase && constants.include?(name) && const_get(name) && methods.include?(name)
			true
		else
			super
		end
	end

	def const_added(name)
		return if autoload?(name)

		constant = const_get(name)

		if Class === constant && constant < Phlex::SGML
			if instance_methods.include?(name)
				raise NameError, "The instance method `#{name}' is already defined on `#{inspect}`."
			elsif methods.include?(name)
				raise NameError, "The method `#{name}' is already defined on `#{inspect}`."
			end

			constant.include(self)

			define_method(name) do |*args, **kwargs, &block|
				render(constant.new(*args, **kwargs), &block)
			end

			define_singleton_method(name) do |*args, **kwargs, &block|
				if (component = Fiber[:__phlex_component__])
					component.instance_exec do
						render(constant.new(*args, **kwargs), &block)
					end
				else
					raise "You can't call `#{name}' outside of a Phlex rendering context."
				end
			end
		end

		super
	end
end
