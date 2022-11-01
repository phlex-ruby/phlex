# frozen_string_literal: true

require "phlex/rails"

Bundler.require :rails

Combustion.path = "fixtures/dummy"

Combustion.initialize! :action_controller do
	config.autoload_paths << "#{root}/app"
end
