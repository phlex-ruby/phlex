# frozen_string_literal: true

require "nokogiri"
require "phlex/test_helpers"

module Phlex
	module Nokogiri
		module TestHelpers
			include Phlex::TestHelpers

			def render(view, &block)
				::Nokogiri::HTML.fragment(super)
			end
		end
	end
end
