# frozen_string_literal: true

require "cgi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/generators")
loader.inflector.inflect("html" => "HTML")
loader.setup

module Phlex
	Error = Module.new
	ArgumentError = Class.new(ArgumentError) { include Error }

	extend self

	ATTRIBUTE_CACHE = {}

	def configuration
		@configuration ||= Configuration.new
	end

	def configure
		yield configuration
	end
end

if defined?(Rails::Engine)
	require "rails"
end
