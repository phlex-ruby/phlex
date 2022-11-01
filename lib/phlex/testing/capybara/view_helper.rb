# frozen_string_literal: true

require "capybara"
require "phlex/testing/view_helper"

module Phlex::Testing
	module Capybara
		module ViewHelper
			include Phlex::Testing::ViewHelper

			attr_accessor :page

			def render(view, &block)
				super.tap do |output|
					@page = ::Capybara::Node::Simple.new(output)
				end
			end
		end
	end
end
