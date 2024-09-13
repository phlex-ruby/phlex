# frozen_string_literal: true

# @api private
module Phlex::ElementClobberingGuard
	def method_added(method_name)
		if method_name[0] == "_" && __element_method__?(method_name[1..].to_sym)
			raise Phlex::NameError.new("👋 Redefining the method `#{name}##{method_name}` is not a good idea.")
		elsif method_name == :view_template
			location = instance_method(method_name).source_location[0]

			if location[0] in "/" | "."
				Phlex.__expand_attribute_cache__(location)
			end
		else
			super
		end
	end
end
