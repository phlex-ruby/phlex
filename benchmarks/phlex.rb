#!/usr/bin/env ruby
# frozen_string_literal: true

# This is the orignal benchmark from the Phlex repo
# It's used to measure the performance of Phlex itself against older versions of itself,
# to measure improvments over time.

require "phlex"
require "benchmark/ips"

require_relative "../fixtures/page"
require_relative "../fixtures/layout"

puts RUBY_DESCRIPTION

a = Example::Page.new.call
# Example::Page.compile
# Example::LayoutComponent.compile
b = Example::Page.new.call

raise unless a == b

Benchmark.ips do |x|
	x.report("Page") { Example::Page.new.call }
end
