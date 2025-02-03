# frozen_string_literal: true

module Phlex::Kit
	module LazyLoader
		def method_missing(name, ...)
			mod = self.class

			if name[0] == name[0].upcase && mod.constants.include?(name) && mod.const_get(name) && methods.include?(name)
				public_send(name, ...)
			else
				super
			end
		end

		def respond_to_missing?(name, include_private = false)
			mod = self.class

			if name[0] == name[0].upcase && mod.constants.include?(name) && mod.const_get(name) && methods.include?(name)
				true
			else
				super
			end
		end
	end

	def self.extended(mod)
		mod.include(LazyLoader)
	end

	def method_missing(name, ...)
		if name[0] == name[0].upcase && constants.include?(name) && const_get(name) && methods.include?(name)
			public_send(name, ...)
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

		me = self
		constant = const_get(name)

		case constant
		when Class
			if constant < Phlex::SGML
				constant.include(self)

				constant = nil

				define_method(name) do |*args, **kwargs, &block|
					constant = me.const_get(name)
					render(constant.new(*args, **kwargs), &block)
				end

				define_singleton_method(name) do |*args, **kwargs, &block|
					component, fiber_id = Thread.current[:__phlex_component__]
					if (component && fiber_id == Fiber.current.object_id)
						component.instance_exec do
							constant = me.const_get(name)
							render(constant.new(*args, **kwargs), &block)
						end
					else
						raise "You can't call `#{name}' outside of a Phlex rendering context."
					end
				end
			end
		when Module
			constant.extend(Phlex::Kit)
		end

		super
	end
end
