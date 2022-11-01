# frozen_string_literal: true

require "phlex/testing/nokogiri/view_helper"

class Example < Phlex::View
	def template
		h1 { "👋" }
	end
end

describe Phlex::Testing::Nokogiri::ViewHelper do
	include Phlex::Testing::Nokogiri::ViewHelper

	describe "#render" do
		it "returns a Nokogiri fragment" do
			output = render Example.new

			expect(output).to be_a Nokogiri::HTML5::DocumentFragment
			expect(output.css("h1").text).to be == "👋"
		end
	end
end
