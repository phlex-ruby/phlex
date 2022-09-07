#!/usr/bin/env ruby
# frozen_string_literal: true

require "phlex"
require "benchmark/ips"

require_relative "fixtures/page"
require_relative "fixtures/layout"

puts RUBY_DESCRIPTION

Benchmark.ips do |x|
  x.warmup = 10
  x.report("Page") { Example::Page.new.call }
end
