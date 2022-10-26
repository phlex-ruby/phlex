# frozen_string_literal: true

module Phlex::View::Callbacks
	def template(&block)
		before_rendering_template if respond_to?(:before_rendering_template)

		super(&block)

		after_rendering_template if respond_to?(:after_rendering_template)
	end
end
