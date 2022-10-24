# frozen_string_literal: true

require "test_helper"
require "phlex/nokogiri/test_helpers"

class Example < Phlex::View
	def template
		h1 { "Hello" }
	end
end

describe Phlex::Nokogiri::TestHelpers do
	include Phlex::Nokogiri::TestHelpers

	describe "#render" do
		it "parses the rendered output to a nokogiri node" do
			expect(render(Example.new)).to be_a Nokogiri::HTML::DocumentFragment
		end
	end
end
