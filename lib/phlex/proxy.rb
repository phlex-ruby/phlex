# frozen_string_literal: true

class Phlex::Proxy < BasicObject
	def self.inliner(block)
		proc do |component|
			proxy = new(component, block.binding.receiver)
			proxy.instance_exec(component, &block)
		end
	end

	def initialize(component, receiver)
		receiver.instance_variables.each do |ivar|
			value = receiver.instance_variable_get(ivar)
			__instance_variable_set__(ivar, value)
		end

		@__component__ = component
		@__receiver__ = receiver
	end

	define_method :__instance_variable_set__,
		::Object.instance_method(:instance_variable_set)

	def respond_to_missing?(name)
		@__receiver__.respond_to?(name) || @__component__.respond_to?(name)
	end

	def method_missing(name, ...)
		if @__receiver__.respond_to?(name)
			@__receiver__.send(name, ...)
		elsif @__component__.respond_to?(name)
			@__component__.send(name, ...)
		else
			# We want the receiver to raise the error.
			@__receiver__.send(name, ...)
		end
	end

	# (In Rails)
	# def method_missing(*, **, &)
	# 	output = super(*, **) { @__component__.capture(&) }

	# 	case output
	# 	when ActiveSupport::SafeBuffer
	# 		@__component__.raw(output)
	# 	else
	# 		output
	# 	end
	# end
end
