# frozen_string_literal: true

module Phlex
	module ElementClobberingGuard
		def method_added(method_name)
			if method_name[0] == "_" && private_instance_methods.include?(:"__phlex#{method_name}__")
				raise NameError, "👋 Redefining the method `#{name}##{method_name}` is not a good idea."
			end

			super
		end
	end
end
