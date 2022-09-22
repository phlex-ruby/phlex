# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	extend ComponentHelper

	with "content" do
		component do
			def template(&block)
				div do
					content(&block)
				end
			end
		end

		it "renders text content" do
			expect(example.call { "Hi" }).to be == "<div>Hi</div>"
		end
	end
end
