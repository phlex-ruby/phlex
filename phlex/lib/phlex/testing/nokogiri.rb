# frozen_string_literal: true

require "nokogiri"
require_relative "view_helper"

module Phlex::Testing
	module Nokogiri
		module DocumentHelper
			include Phlex::Testing::ViewHelper

			def render(view, &block)
				::Nokogiri::HTML5(super)
			end
		end

		module FragmentHelper
			include Phlex::Testing::ViewHelper

			def render(view, &block)
				::Nokogiri::HTML5.fragment(super)
			end
		end
	end
end
