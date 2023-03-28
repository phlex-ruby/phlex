# frozen_string_literal: true

module Phlex::ComponentRegistrar
	def register_components(**components)
		components.each do |helper_name, component_class|
			define_method helper_name do |*args, **kwargs, &block|
				render component_class.new(*args, **kwargs), &block
			end
		end
	end
end
