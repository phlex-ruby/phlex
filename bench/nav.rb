#!/usr/bin/env ruby

require "phlex"
require "benchmark/ips"

class NavComponent < Phlex::Component
  def template
    nav id: "main_nav" do
      ul do
        li { a "Home", href: "/" }
        li { a "About", href: "/about" }
        li { a "Contact", href: "/contact" }
      end
    end
  end
end

puts RUBY_DESCRIPTION

Benchmark.ips do |x|
  x.report("NavComponent") { NavComponent.new.call }
end
