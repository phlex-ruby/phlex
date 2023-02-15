# frozen_string_literal: true

require "erb"
require "zeitwerk"
require "concurrent"

module Phlex
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.inflector.inflect(
			"html" => "HTML",
			"svg" => "SVG",
			"xml" => "XML"
		)
		loader.ignore("#{__dir__}/phlex/testing")
		loader.setup
	end

	Error = Module.new
	ArgumentError = Class.new(ArgumentError) { include Error }
	NameError = Class.new(NameError) { include Error }

	ATTRIBUTE_CACHE = Concurrent::Map.new
end
