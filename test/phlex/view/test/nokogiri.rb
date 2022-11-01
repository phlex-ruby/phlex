require "test_helper"
require "phlex/view/test/nokogiri"

class Example < Phlex::View
	def template
		h1 { "👋" }
	end
end

describe Phlex::View::Test::Nokogiri do
	include Phlex::View::Test::Nokogiri

	describe "#render" do
		it "returns a Nokogiri fragment" do
			output = render Example.new

			expect(output).to be_a Nokogiri::HTML5::DocumentFragment
			expect(output.css("h1").text).to be == "👋"
		end
	end
end
