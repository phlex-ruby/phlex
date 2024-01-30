# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "a doctype" do
		view do
			def view_template
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
