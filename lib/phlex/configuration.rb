# frozen_string_literal: true

module Phlex
	class Configuration
		attr_writer :experimental_warnings

		def experimental_warnings
			return @experimental_warnings if defined? @experimental_warnings

			true
		end
	end
end
