# frozen_string_literal: true

require "erb"
require "zeitwerk"
require "concurrent"

module Phlex
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.inflector.inflect("html" => "HTML")
		loader.ignore("#{__dir__}/phlex/testing")
		loader.setup
	end

	Error = Module.new

	class ArgumentError < ::ArgumentError
		include Error
	end

	class NameError < ::NameError
		include Error
	end

	ATTRIBUTE_CACHE = Concurrent::Map.new
end
