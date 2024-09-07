# frozen_string_literal: true

module Phlex::Testing::SGML
	def render_to_string(component, &)
		component.call(view_context:, &)
	end

	def view_context = nil
end
