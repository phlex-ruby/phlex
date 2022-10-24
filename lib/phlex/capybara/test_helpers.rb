# frozen_string_literal: true

require "capybara"
require "phlex/test_helpers"

module Phlex
	module Capybara
		module TestHelpers
			include Phlex::TestHelpers

			def page
				::Capybara::Node::Simple.new(@output)
			end
		end
	end
end
