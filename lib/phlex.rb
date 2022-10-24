# frozen_string_literal: true

require "cgi"
require "zeitwerk"
require "syntax_tree"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.ignore("#{__dir__}/generators")
loader.ignore("#{__dir__}/install")
loader.ignore("#{__dir__}/phlex/test_helpers.rb")
loader.ignore("#{__dir__}/phlex/capybara/test_helpers.rb")
loader.ignore("#{__dir__}/phlex/nokogiri/test_helpers.rb")
loader.ignore("#{__dir__}/phlex/rails/test_helpers.rb")
loader.inflector.inflect("html" => "HTML")
loader.inflector.inflect("vcall" => "VCall")
loader.inflector.inflect("fcall" => "FCall")
loader.setup

module Phlex
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

begin
	require "rails"
	require "phlex/engine"
rescue LoadError
	# Rails isn't in this env, don't load the engine.
end
