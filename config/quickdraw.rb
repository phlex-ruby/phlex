# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
	require "simplecov"
	SimpleCov.command_name "quickdraw"
	SimpleCov.start do
		enable_coverage :branch
		primary_coverage :branch
	end
end

Bundler.require :test
require "phlex"

# Previous content of test helper now starts here
$LOAD_PATH.unshift(File.expand_path("../fixtures", __dir__))
