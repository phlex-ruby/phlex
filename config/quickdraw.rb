# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
	require "simplecov"

	SimpleCov.start do
		command_name "quickdraw"
		enable_coverage_for_eval
		enable_coverage :branch
		add_filter %r{^/fixtures/}

		add_group "SGML", "lib/phlex/sgml"
		add_group "HTML", "lib/phlex/html"
		add_group "SVG", "lib/phlex/svg"
		add_group "CSV", "lib/phlex/csv"
	end
end

Bundler.require :test
require "phlex"

# Previous content of test helper now starts here
$LOAD_PATH.unshift(File.expand_path("../fixtures", __dir__))
