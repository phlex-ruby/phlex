# frozen_string_literal: true

require "nokogiri"

module Phlex::Testing::Nokogiri
	include Phlex::Testing::SGML

	def render_fragment(...)
		::Nokogiri::HTML5.fragment(
			render_to_string(...),
		)
	end

	def render_document(...)
		::Nokogiri::HTML5(
			render_to_string(...),
		)
	end
end
