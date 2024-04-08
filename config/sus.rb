# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
	enable_coverage :branch
end

SimpleCov.command_name "Unit Tests"

require "phlex"
require "bundler"

Bundler.require :test

require_relative "../fixtures/view_helper"
