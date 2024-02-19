#!/usr/bin/env ruby
# frozen_string_literal: true

require "phlex"
require "benchmark/ips"

require_relative "fixtures/page"
require_relative "fixtures/layout"

a = Example::Page.new.call
# Example::Page.compile
# Example::LayoutComponent.compile
b = Example::Page.new.call

raise unless a == b

Benchmark.ips do |x|
	x.report("Page") { Example::Page.new.call }
end
