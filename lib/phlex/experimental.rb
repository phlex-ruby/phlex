# frozen_string_literal: true

module Phlex
	module Experimental
		include Phlex::Callbacks

		def before_rendering_template
			puts "Warning: #{self.class.name} is experimental and subject to change."
			super
		end
	end
end
