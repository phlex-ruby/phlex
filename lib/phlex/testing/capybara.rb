# frozen_string_literal: true

require "capybara"
require_relative "view_helper"

module Phlex::Testing
	module Capybara
		module ViewHelper
			include Phlex::Testing::ViewHelper

			def self.included(klass)
				if defined?(Minitest::Test) && klass < Minitest::Test
					require "capybara/minitest"
					include ::Capybara::Minitest::Assertions
				end
			end

			attr_accessor :page

			def render(view, &block)
				@page = ::Capybara::Node::Simple.new(super)
			end
		end
	end
end
