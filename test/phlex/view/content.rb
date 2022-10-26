# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	with "content" do
		view do
			def template(&)
				div do
					yield_content(&)
				end
			end
		end

		it "renders text content" do
			expect(example.call { "Hi" }).to be == "<div>Hi</div>"
		end
	end
end
