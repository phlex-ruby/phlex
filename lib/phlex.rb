# frozen_string_literal: true

require "erb"

module Phlex
	autoload :ArgumentError, "phlex/errors/argument_error"
	autoload :BlackHole, "phlex/black_hole"
	autoload :CSV, "phlex/csv"
	autoload :Callable, "phlex/callable"
	autoload :ConcurrentMap, "phlex/concurrent_map"
	autoload :Context, "phlex/context"
	autoload :DeferredRender, "phlex/deferred_render"
	autoload :ElementClobberingGuard, "phlex/element_clobbering_guard"
	autoload :Elements, "phlex/elements"
	autoload :Error, "phlex/error"
	autoload :HTML, "phlex/html"
	autoload :Helpers, "phlex/helpers"
	autoload :Kit, "phlex/kit"
	autoload :NameError, "phlex/errors/name_error"
	autoload :SGML, "phlex/sgml"
	autoload :SVG, "phlex/svg"
	autoload :Unbuffered, "phlex/unbuffered"

	Escape = ERB::Escape

	# @api private
	ATTRIBUTE_CACHE = {}

	SUPPORTS_FIBER_STORAGE = RUBY_ENGINE == "ruby"
end

def 💪
	Phlex
end
