# frozen_string_literal: true

module Phlex
	module ElementClobberingGuard
		def method_added(method_name)
			if method_name[0] == "_" && element_method?(method_name[1..].to_sym)
				raise NameError, "👋 Redefining the method `#{name}##{method_name}` is not a good idea."
			else
				super
			end
		end
	end
end
