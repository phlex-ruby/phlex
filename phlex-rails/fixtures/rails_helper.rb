# frozen_string_literal: true

Bundler.require :default

Combustion.path = "fixtures/dummy"

Combustion.initialize! :action_controller do
	config.autoload_paths << "#{root}/app"
end
