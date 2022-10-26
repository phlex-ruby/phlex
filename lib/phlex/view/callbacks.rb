# frozen_string_literal: true

module Phlex::View::Callbacks
	def template(&block)
		respond_to?(:before_template) && before_template

		super(&block)

		respond_to?(:after_template) && after_template
	end
end
