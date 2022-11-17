# frozen_string_literal: true

require "covered/sus"
include Covered::Sus

require "phlex"
require "bundler"

Bundler.require :test

require_relative "../fixtures/view_helper"
require_relative "../fixtures/compiler_test_helpers"

Zeitwerk::Loader.eager_load_all
