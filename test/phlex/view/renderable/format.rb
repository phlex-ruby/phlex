# frozen_string_literal: true

describe Phlex::View do
	extend ViewHelper

	view

	with "format" do
		it "returns :html" do
			expect(example.format).to be == :html
		end
	end
end
