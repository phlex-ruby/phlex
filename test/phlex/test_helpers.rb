# frozen_string_literal: true

require "test_helper"
require "phlex/test_helpers"

class Example < Phlex::View
	def template(&content)
		ul(&content)
	end

	def item(&content)
		li(&content)
	end
end

describe Phlex::TestHelpers do
	include Phlex::TestHelpers

	describe "#render" do
		it "renders the view" do
			expect(render(Example.new)).to be == %(<ul></ul>)
		end

		it "accepts content block" do
			output = render(Example.new) do |nav|
				nav.item { "Menu A" }
			end

			expect(output.to_s).to be == %(<ul><li>Menu A</li></ul>)
		end

		it "stores the rendered output in the @output instance variable" do
			render Example.new
			expect(@output).to be == %(<ul></ul>)
		end
	end
end
