# frozen_string_literal: true

require "capybara"
require "phlex/view/test"

module Phlex::View::Test::Capybara
	include Phlex::View::Test

	attr_accessor :page

	def render(view, &block)
		super.tap do |output|
			@page = ::Capybara::Node::Simple.new(output)
		end
	end
end
