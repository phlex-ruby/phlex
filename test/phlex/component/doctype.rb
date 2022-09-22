# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	extend ComponentHelper

	with "a doctype" do
		component do
			def template
				html do
					head { doctype }
				end
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<html><head><!DOCTYPE html></head></html>"
		end
	end
end
