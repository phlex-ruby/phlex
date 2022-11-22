# frozen_string_literal: true

require "cgi"
require "zeitwerk"

module Phlex
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.inflector.inflect("html" => "HTML")
		loader.ignore("#{__dir__}/phlex/testing")
		loader.setup
	end

	Error = Module.new
	ArgumentError = Class.new(ArgumentError) { include Error }
	NameError = Class.new(NameError) { include Error }

	extend self

	ATTRIBUTE_CACHE = {}

	def configuration
		@configuration ||= Configuration.new
	end

	def configure
		yield configuration
	end
end
