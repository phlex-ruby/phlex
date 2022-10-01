# frozen_string_literal: true

require "phlex"
require "bundler"

Bundler.require :test

Combustion.path = "fixtures/dummy"
Combustion.initialize! :action_controller do
	config.autoload_paths << "#{root}/app"
end

require "view_helper"

Zeitwerk::Loader.eager_load_all
