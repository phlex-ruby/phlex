# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
	require "simplecov"

	SimpleCov.start do
		command_name "quickdraw"
		enable_coverage_for_eval
		enable_coverage :branch
		minimum_coverage 100
	end
end

Bundler.require :test
require "phlex"

# Previous content of test helper now starts here
$LOAD_PATH.unshift(File.expand_path("../fixtures", __dir__))
