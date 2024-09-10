# frozen_string_literal: true

module Phlex::Kit
	module LazyLoader
		def method_missing(name, ...)
			if name[0] == name[0].upcase && __phlex_kit_constants__.include?(name) && __get_phlex_kit_constant__(name) && methods.include?(name)
				public_send(name, ...)
			else
				super
			end
		end

		def respond_to_missing?(name, include_private = false)
			if name[0] == name[0].upcase && __phlex_kit_constants__.include?(name) && __get_phlex_kit_constant__(name) && methods.include?(name)
				true
			else
				super
			end
		end
	end

	include LazyLoader

	def self.extended(mod)
		mod.include(LazyLoader)
		mod.define_method(:__phlex_kit_constants__) { mod.__phlex_kit_constants__ }
		mod.define_method(:__get_phlex_kit_constant__) { |name| mod.__get_phlex_kit_constant__(name) }
	end

	def __phlex_kit_constants__
		constants
	end

	def __get_phlex_kit_constant__(name)
		const_get(name)
	end

	def const_added(name)
		return if autoload?(name)

		me = self
		constant = const_get(name)

		if Class === constant && constant < Phlex::SGML
			constant.include(self)

			define_method(name) do |*args, **kwargs, &block|
				constant = me.const_get(name)
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
