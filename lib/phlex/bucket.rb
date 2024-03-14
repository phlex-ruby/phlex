# frozen_string_literal: true

module Phlex::Bucket
	def self.extended(mod)
		warn "🚨 [WARNING] Phlex::Bucket is experimental and may be removed from future versions of Phlex."

		# Eager load all constants in the module for apps that use Zeitwerk.
		mod.constants.each { |c| mod.const_added(c) if mod.autoload?(c) }
	end

	def const_added(name)
		if autoload?(name)
			define_method(name) do |*args, **kwargs, &block|
				this = method(name)
				self.class.const_get(name) # load the constant (which should override this method)

				if this == method(name)
					# loading the constant didn't override this method
					super
				else
					public_send(name, *args, **kwargs, &block) # call this method again
				end
			end

			define_singleton_method(name) do |*args, **kwargs, &block|
				this = method(name)
				const_get(name) # load the constant (which should override this method)

				if this == method(name)
					# loading the constant didn't override this method
					super
				else
					public_send(name, *args, **kwargs, &block) # call this method again
				end
			end
		else
			constant = const_get(name)

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
end
