# frozen_string_literal: true

require "phlex"
require "bundler"
require "view_helper"

Bundler.require :test
Zeitwerk::Loader.eager_load_all
