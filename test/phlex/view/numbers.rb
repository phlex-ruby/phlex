# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	with "numbers" do
		view do
			def template
				span 1
				span 2.0
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<span>1</span><span>2.0</span>"
		end
	end

	with "numbers in block" do
		view do
			def template
				span do
					1
				end

				span do
					2.0
				end
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<span>1</span><span>2.0</span>"
		end
	end
end
