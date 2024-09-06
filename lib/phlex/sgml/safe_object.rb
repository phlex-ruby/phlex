# frozen_string_literal: true

# @api private
module Phlex::SGML::SafeObject
	# This is included in objects that are safe to render in an SGML context.
	# They must implement a `to_s` method that returns a string.
end
