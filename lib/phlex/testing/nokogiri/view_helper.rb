# frozen_string_literal: true

require "nokogiri"
require "phlex/testing/view_helper"

module Phlex::Testing
	module Nokogiri
		module ViewHelper
			include Phlex::Testing::ViewHelper

			def render(view, &block)
				::Nokogiri::HTML5.fragment(super)
			end
		end
	end
end
