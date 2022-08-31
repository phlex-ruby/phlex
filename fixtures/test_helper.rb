# frozen_string_literal: true

require "phlex"
require "bundler"
Bundler.require :test
Combustion.initialize! :action_controller
require "component_helper"
