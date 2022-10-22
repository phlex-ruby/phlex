# frozen_string_literal: true

module Phlex
	module TestHelpers
		class MissingTestDependency < StandardError; end

		attr_reader :rendered

		def render_view(view, &block)
			ensure_presence_of_nokogiri!

			@page = nil # page is memoized with rendered , this will force page to be evaluated with new content

			view_context = controller&.view_context
			@rendered = view.call(view_context: view_context, &block)
			Nokogiri::HTML.fragment(rendered)
		end

		def controller
			return @controller if defined?(@controller)

			@controller = if defined?(ActionView::TestCase::TestController)
				ActionView::TestCase::TestController.new
			end
		end

		def page
			@page ||= begin
				ensure_presence_of_capybara!

				Capybara::Node::Simple.new(rendered)
			end
		end

		private

		def ensure_presence_of_nokogiri!
			return if defined?(Nokogiri)

			message = "You need to add `nokogiri` to your application dependencies in order to use `render_view` method"
			raise MissingTestDependency, message
		end

		def ensure_presence_of_capybara!
			return if defined?(Capybara)

			message = "You need to add `capybara` to your application dependencies in order to assert against rendered view"
			raise MissingTestDependency, message
		end
	end
end
