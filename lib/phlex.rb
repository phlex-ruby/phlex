# frozen_string_literal: true

require "erb"

module Phlex
	autoload :BlackHole, "phlex/black_hole"
	autoload :Callable, "phlex/callable"
	autoload :ConcurrentMap, "phlex/concurrent_map"
	autoload :Context, "phlex/context"
	autoload :CSV, "phlex/csv"
	autoload :DeferredRender, "phlex/deferred_render"
	autoload :ElementClobberingGuard, "phlex/element_clobbering_guard"
	autoload :Elements, "phlex/elements"
	autoload :FIFO, "phlex/fifo"
	autoload :Helpers, "phlex/helpers"
	autoload :HTML, "phlex/html"
	autoload :SGML, "phlex/sgml"
	autoload :SVG, "phlex/svg"
	autoload :Unbuffered, "phlex/unbuffered"

	# Included in all Phlex exceptions allowing you to match any Phlex error.
	# @example Rescue any Phlex error:
	#  rescue Phlex::Error
	module Error; end

	if defined?(ERB::Escape)
		Escape = ERB::Escape
	else
		Escape = ERB::Util
	end

	# A specialised ArgumentError for Phlex.
	class ArgumentError < ::ArgumentError
		include Error
	end

	# A specialised NameError for Phlex.
	class NameError < ::NameError
		include Error
	end

	# @api private
	ATTRIBUTE_CACHE = Phlex::FIFO.new(20_000_000)
end

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	class Symbol
		def name
			to_s
		end
	end
end

def 💪
	Phlex
end
