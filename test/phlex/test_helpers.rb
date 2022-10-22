# frozen_string_literal: true

require "test_helper"
require "phlex/test_helpers"
require "capybara"

describe Phlex::TestHelpers do
	include Phlex::TestHelpers

	describe "#render_view" do
		it "parses rendered string in to a nokogiri nodeset" do
			view = Class.new(Phlex::View) do
				def template
					h2 { "Some title" }
				end
			end

			output = render_view(view.new)

			expect(output.class).to be == Nokogiri::HTML::DocumentFragment
		end

		it "accepts content block" do
			nav_view = Class.new(Phlex::View) do
				def template(&content)
					ul(&content)
				end

				def item(&content)
					li(&content)
				end
			end

			output = render_view(nav_view.new) do |nav|
				nav.item { "Menu A" }
				nav.item { "Menu B" }
			end

			expect(output.to_s).to be == %(<ul>\n<li>Menu A</li>\n<li>Menu B</li>\n</ul>)
		end

		it "uses controller view context" do
			view = Class.new(Phlex::View) do
				def template
					h1 { "Hello" }
				end
			end
			example = view.new
			view_context = controller.view_context

			mock(controller) do |mock|
				mock.replace(:view_context) do
					view_context
				end
			end

			expect(example).to receive(:call).with(view_context: view_context)

			render_view(example)
		end

		with "controller not present" do
			it "renders without problem" do
				expect(self).to receive(:controller).and_return(nil)

				view = Class.new(Phlex::View) do
					def template
						h1 { "Hello" }
					end
				end

				result = render_view(view.new)

				expect(result.to_s).to be == "<h1>Hello</h1>"
			end
		end

		with "Nokogiri missing" do
			it "raises error" do
				nokogiri_const = ::Nokogiri
				Object.send :remove_const, :Nokogiri

				message = "You need to add `nokogiri` to your application dependencies in order to use `render_view` method"

				expect do
					render_view(Phlex::View.new)
				end.to raise_exception(Phlex::TestHelpers::MissingTestDependency, message: be == message)

				::Nokogiri = nokogiri_const
			end
		end
	end

	describe "#controller" do
		with "ActionView::TestCase::TestController defined" do
			it "returns a new TestController instance" do
				expect(controller).to be(:kind_of?, ActionView::TestCase::TestController)
			end
		end

		with "ActionView::TestCase::TestController missing" do
			it "returns nil" do
				action_view_const = ::ActionView
				Object.send :remove_const, :ActionView

				expect(controller.nil?).to be == true

				::ActionView = action_view_const
			end
		end

		it "memoizes result" do
			stored_controller = controller

			# If memoization doesn't work, the `controller` should be a different instance
			expect(controller).to be == stored_controller
		end
	end

	describe "#page" do
		it "returns rendered view as capybara node" do
			view = Class.new(Phlex::View) do
				def template
					h1 { "Hello" }
				end
			end

			render_view(view.new)

			expect(page.all("h1").first.text).to be == "Hello"
		end

		it "memoizes result" do
			view = Class.new(Phlex::View) do
				def template
					h1 { "Hello" }
				end
			end

			render_view(view.new)

			stored_page = page

			# if memoization doesn't work, the `page` should be a different instance
			expect(page).to be == stored_page
		end

		with "`render_view` beign called multiple times" do
			it "returns last content rendered" do
				first_view = Class.new(Phlex::View) do
					def template
						span { "First view" }
					end
				end

				second_view = Class.new(Phlex::View) do
					def template
						span { "Second view" }
					end
				end

				render_view(first_view.new)
				render_view(second_view.new)

				expect(page.all("span").first.text).to be == "Second view"
			end
		end

		with "Capybara missing" do
			it "raises error" do
				capybara_const = ::Capybara
				Object.send :remove_const, :Capybara

				message = "You need to add `capybara` to your application dependencies in order to assert against rendered view"

				expect { page }.to raise_exception(Phlex::TestHelpers::MissingTestDependency, message: be == message)

				::Capybara = capybara_const
			end
		end
	end
end
