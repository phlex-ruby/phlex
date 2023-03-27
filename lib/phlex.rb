# frozen_string_literal: true

require "erb"
require "zeitwerk"
require "concurrent"

module Phlex
	# Included in all Phlex exceptions allowing you to match any Phlex error.
	# @example Rescue any Phlex error:
	#  rescue Phlex::Error
	module Error; end

	# A specialised ArgumentError for Phlex.
	class ArgumentError < ::ArgumentError
		include Error
	end

	# A specialised NameError for Phlex.
	class NameError < ::NameError
		include Error
	end

	# @api private
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.inflector.inflect(
			"html" => "HTML",
				"svg" => "SVG",
				"sgml" => "SGML"
		)
		loader.ignore("#{__dir__}/phlex/testing")
		loader.setup
	end

	# @api private
	ATTRIBUTE_CACHE = Concurrent::Map.new
end
