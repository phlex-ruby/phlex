# frozen_string_literal: true

module Phlex
	module TestHelpers
		class MissingTestDependency < StandardError; end

		def render_view(view, &block)
			ensure_presence_of_nokogiri

			view_context = controller&.view_context
			rendered = view.call(view_context: view_context, &block)
			Nokogiri::HTML.fragment(rendered)
		end

		def controller
			return @controller if defined?(@controller)

			@controller = if defined?(ActionView::TestCase::TestController)
				ActionView::TestCase::TestController.new
			end
		end

		private

		def ensure_presence_of_nokogiri
			return if defined?(Nokogiri)

			message = "You need to add `nokogiri` to your application dependencies in order to use `render_view` method"
			raise MissingTestDependency, message
		end
	end
end
