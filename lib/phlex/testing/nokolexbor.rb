# frozen_string_literal: true

require "nokolexbor"

module Phlex::Testing::Nokolexbor
	include Phlex::Testing::SGML

	def render_fragment(...)
		Nokolexbor::DocumentFragment.parse(
			render_to_string(...),
		)
	end

	def render_document(...)
		::Nokolexbor::HTML(
			render_to_string(...),
		)
	end
end
