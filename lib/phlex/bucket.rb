# frozen_string_literal: true

module Phlex::Bucket
	def self.extended(mod)
		warn "🚨 [WARNING] Phlex::Bucket is experimental and may be removed from future versions of Phlex."

		# Eager load all constants in the module for apps that use Zeitwerk.
		mod.constants.each { |c| mod.const_get(c) }
	end

	def const_added(name)
		# This can sometime be triggered by an autoload, which means it gets
		# triggered a second time when we call `const_get` below and Ruby loads it.
		return super if Fiber[:__phlex_adding_bucket_const__]

		begin
			Fiber[:__phlex_adding_bucket_const__] = true
			constant = const_get(name)
		ensure
			Fiber[:__phlex_adding_bucket_const__] = false
		end

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
