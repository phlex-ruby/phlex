# frozen_string_literal: true

require "rails_helper"

describe Phlex::Rails::Helpers::FormWith do
	let(:output) { ArticlesController.render "edit" }

	with "form_with" do
		it "renders the form" do
			expect(output).to be ==
				%(<form action="test" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" autocomplete="off" /><input class="input input-bordered" type="text" name="name" /></form>\n)
		end
	end
end
