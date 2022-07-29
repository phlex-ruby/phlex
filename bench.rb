#!/usr/bin/env ruby

require "phlex"
require "benchmark/ips"

require_relative "examples/page"
require_relative "examples/layout"

puts RUBY_DESCRIPTION

Benchmark.ips do |x|
  x.report("Page") { Example::Page.new.call }
end
