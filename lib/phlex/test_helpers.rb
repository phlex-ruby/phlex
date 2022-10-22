# frozen_string_literal: true

module Phlex
	module TestHelpers
		def render_view(view, &block)
			rendered = controller.view_context.render(view, &block)
			Nokogiri::HTML.fragment(rendered)
		end

		def controller
			ActionView::TestCase::TestController.new
		end
	end
end
