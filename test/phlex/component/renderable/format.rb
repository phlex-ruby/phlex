# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	extend ComponentHelper

	component

	with "format" do
		it "returns :html" do
			expect(example.format).to be == :html
		end
	end
end
