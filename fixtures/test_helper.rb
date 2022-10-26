# frozen_string_literal: true

require "ruby-next/language/runtime"
require "simplecov"
SimpleCov.start

require "phlex"
require "bundler"
require "view_component"

Bundler.require :test

Combustion.path = "fixtures/dummy"
Combustion.initialize! :action_controller do
	config.autoload_paths << "#{root}/app"
end

require "view_helper"

Zeitwerk::Loader.eager_load_all
