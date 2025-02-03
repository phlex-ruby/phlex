# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
	require "simplecov"

	SimpleCov.start do
		command_name "quickdraw"
		enable_coverage_for_eval
		enable_for_subprocesses true
		enable_coverage :branch
		add_filter %r{^/fixtures/}

		add_group "SGML", "lib/phlex/sgml"
		add_group "HTML", "lib/phlex/html"
		add_group "SVG", "lib/phlex/svg"
		add_group "CSV", "lib/phlex/csv"
	end
end

Bundler.require :test

module AutoloadRecorder
	AUTOLOADS = []

	def self.load_all
		AUTOLOADS.each do |(mod, name)|
			mod.const_get(name)
		end
	end

	def autoload(name, path)
		super
		::AutoloadRecorder::AUTOLOADS << [self, name].freeze
	end
end

Module.prepend(AutoloadRecorder)

require "phlex"

AutoloadRecorder.load_all

# Previous content of test helper now starts here
$LOAD_PATH.unshift(File.expand_path("../fixtures", __dir__))
