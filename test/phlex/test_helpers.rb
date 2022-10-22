# frozen_string_literal: true

require "test_helper"
require "phlex/test_helpers"

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
	end
end
