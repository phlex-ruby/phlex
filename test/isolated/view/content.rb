# frozen_string_literal: true

require "isolated_test_helper"

describe Phlex::View do
	extend ViewHelper

	with "content" do
		view do
			def template(&block)
				div do
					yield_content(&block)
				end
			end
		end

		it "renders text content" do
			expect(example.call { "Hi" }).to be == "<div>Hi</div>"
		end
	end
end
