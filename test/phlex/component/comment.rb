# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	extend ComponentHelper

	with "simple comment" do
		component do
			def template
				comment "This is an HTML comment"
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<!-- This is an HTML comment -->"
		end
	end

	with "empty comment" do
		component do
			def template
				comment
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<!--  -->"
		end
	end

	with "number comment" do
		component do
			def template
				comment 1
			end
		end

		it "produces the correct output" do
			expect(output).to be == "<!-- 1 -->"
		end
	end
end
