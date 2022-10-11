#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true

require "phlex"
require "bundler"
require "fileutils"

Bundler.require :docs

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.ignore(__FILE__)
loader.enable_reloading
loader.setup
loader.eager_load

PageBuilder.build_all

if ARGV.include? "--watch"
	Filewatcher.new("#{__dir__}/**/*rb").watch do |_changes|
		loader.reload
		loader.eager_load
		PageBuilder.build_all
	end
end
