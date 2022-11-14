# frozen_string_literal: true

module Pages
	module Testing
		class Rails < ApplicationPage
			def template
				render Layout.new(title: "Testing Phlex Views in Rails") do
					render Markdown.new(<<~MD)
						# Testing Phlex views in Rails

						When you include `Phlex::Testing::Rails::ViewHelper`, views rendered in the test will have a view context, so they can use Rails helpers.
					MD
				end
			end
		end
	end
end
