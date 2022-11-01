# frozen_string_literal: true

require "nokogiri"
require "phlex/view/test"

module Phlex::View::Test::Nokogiri
	include Phlex::View::Test

	def render(view, &block)
		::Nokogiri::HTML5.fragment(super)
	end
end
