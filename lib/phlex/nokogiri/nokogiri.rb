# frozen_string_literal: true

module Phlex
	module Nokogiri
		module TestHelpers
			include Phlex::TestHelpers

			def render(view, &block)
				Nokogiri::HTML.fragment(super)
			end
		end
	end
end
