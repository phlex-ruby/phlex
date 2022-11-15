# frozen_string_literal: true

require "hescape"
require "zeitwerk"
require "syntax_tree"

module Phlex
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.ignore("#{__dir__}/generators")
		loader.ignore("#{__dir__}/install")

		loader.ignore("#{__dir__}/phlex/testing")

		loader.ignore("#{__dir__}/phlex/rails.rb")
		loader.ignore("#{__dir__}/phlex/rails")

		loader.inflector.inflect("html" => "HTML")
		loader.inflector.inflect("vcall" => "VCall")
		loader.inflector.inflect("fcall" => "FCall")
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
