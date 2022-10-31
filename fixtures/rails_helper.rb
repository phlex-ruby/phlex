# frozen_string_literal: true

require "test_helper"

Bundler.require :rails

Combustion.path = "fixtures/dummy"

Combustion.initialize! :action_controller do
	config.autoload_paths << "#{root}/app"
end
