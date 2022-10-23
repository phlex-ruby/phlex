# frozen_string_literal: true

require "test_helper"

describe Phlex::Rails::Helpers do
	with "link_to without block" do
		let(:output) { ArticlesController.render "show" }

		it "renders the link" do
			expect(output).to be == %(<a href="/">Go Back Home</a>)
		end
	end

	with "link_to with block" do
		let(:output) { ArticlesController.render "show_with_image" }

		it "renders the link" do
			expect(output).to be == %(<a class="link" href="/">Go Back Home<img src="/go/back.gif"></a>)
		end
	end
end
