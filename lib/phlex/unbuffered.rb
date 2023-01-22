# frozen_string_literal: true

module Phlex
	class Unbuffered < BasicObject
		CACHE = {}

		def self.call(object)
			decorator = CACHE[object.class.name] ||= ::Class.new(self)
			decorator.new(object)
		end

		def initialize(object)
			@object = object
		end

		def inspect
			"Unbuffered(#{@object.class.name})[object: #{@object.inspect}]"
		end

		# Borrow some important methods from Object
		define_method :__class__,
			::Object.instance_method(:class)

		define_method :__public_send__,
			::Object.instance_method(:public_send)

		define_method :__callee__,
			::Object.instance_method(:__callee__)

		def respond_to_missing?(...)
			@object.respond_to?(...)
		end

		def method_missing(name, *args, &block)
			if @object.respond_to?(name)
				# If the object responds to this method, we want to define it by aliasing the __output_method__.
				__class__.alias_method(name, :__output_method__)

				# Now we've defined this missing method, we can call it.
				__public_send__(name, *args, &block)
			else
				super
			end
		end

		# This method is designed to be aliased and references the callee which is whatever alias you called.
		def __output_method__(*args, &block)
			@object.capture { @object.public_send(__callee__, *args, &block) }
		end

		def __forward_method__(*args, &block)
			@object.public_send(__callee__, *args, &block)
		end

		# Forward some methods to the original underlying method
		alias_method :call, :__forward_method__
		alias_method :send, :__forward_method__
		alias_method :public_send, :__forward_method__
	end
end
