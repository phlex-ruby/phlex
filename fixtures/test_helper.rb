# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
	enable_coverage :branch
	primary_coverage :branch

	add_filter "/fixtures/"

	add_group "Compiler", %{/lib/phlex/compiler}
	add_group "Experimental Stdlib", %r{/lib/phlex/(table|collection)\.rb}
	add_group "Rails", %r{/lib/phlex/rails}
end

require "phlex"
require "bundler"
require "view_component"

Bundler.require :test

require "view_helper"
require "compiler_test_helpers"

Zeitwerk::Loader.eager_load_all
