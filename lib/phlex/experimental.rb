# frozen_string_literal: true

module Phlex
	module Experimental
		def before_template
			puts "Warning: #{self.class.name} is experimental and subject to change."
			super
		end
	end
end
