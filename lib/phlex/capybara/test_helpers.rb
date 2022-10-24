# frozen_string_literal: true

module Phlex
	module Capybara
		module TestHelpers
			include Phlex::TestHelpers

			def page
				Capybara::Node::Simple.new(@output)
			end
		end
	end
end
