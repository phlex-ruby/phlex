#!/usr/bin/env ruby
# frozen_string_literal: true

require "phlex"
require "bundler"
require "fileutils"

Bundler.require :docs

Zeitwerk::Loader.new.tap do |loader|
  loader.push_dir(__dir__)
  loader.ignore(__FILE__)
  loader.setup
  loader.eager_load
end

FileUtils.mkdir_p("#{__dir__}/dist")
FileUtils.cp_r("#{__dir__}/assets", "#{__dir__}/dist")

PageBuilder.build_all

system "npx tailwindcss -i ./docs/assets/application.css -o ./docs/dist/application.css"
