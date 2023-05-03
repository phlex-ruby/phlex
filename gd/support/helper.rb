# frozen_string_literal: true

require "phlex"
require "bundler"

Bundler.require :test

module TestHelper
	def build_component_with_template(&block)
		Class.new(Phlex::HTML) { define_method(:template, &block) }
	end
end

module ToRender
	def to_render(expected_output)
		output = subject.call
		assert(output == expected_output) { "Expected `#{output.inspect}` to equal `#{expected_output.inspect}`." }
	end
end

GreenDots.configure do |config|
	config.register_matcher ToRender, Phlex::SGML
end
