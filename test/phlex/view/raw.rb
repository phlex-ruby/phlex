# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "raw unsafe content" do
		view do
			def view_template
				raw %(<h1 class="test">Hello</h1>)
			end
		end

		it "renders the correct output" do
			expect { output }.to raise_exception ArgumentError
		end
	end

	with "raw safe content" do
		view do
			def view_template
				raw safe %(<h1 class="test">Hello</h1>)
			end
		end

		it "renders the correct output" do
			expect(output).to be == %(<h1 class="test">Hello</h1>)
		end
	end

	with "nil content" do
		view do
			def view_template
				raw nil
			end
		end

		it "renders empty output" do
			expect(output).to be == ""
		end
	end
end
