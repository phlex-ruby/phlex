# frozen_string_literal: true

module Phlex::Callbacks
	def self.prepended(mod)
		raise "Phlex::HTML::Callbacks should be included rather than prepended."
	end

	def around_template(&block)
		before_rendering_template
		super
		after_rendering_template
	end

	def before_rendering_template
		nil
	end

	def after_rendering_template
		nil
	end
end
