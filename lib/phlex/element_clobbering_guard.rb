# frozen_string_literal: true

# @api private
module Phlex::ElementClobberingGuard
	def method_added(method_name)
		if method_name[0] == "_" && element_method?(method_name[1..].to_sym)
			raise Phlex::NameError.new("👋 Redefining the method `#{name}##{method_name}` is not a good idea.")
		else
			super
		end
	end
end
