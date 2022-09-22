# frozen_string_literal: true

require "test_helper"
require "phlex/rails"

describe Phlex::Component do
	let(:output) { ArticlesController.render "new" }

	with "form_with" do
		it "renders the form" do
			expect(output).to be ==
								%(<form action="test" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" autocomplete="off" /><input type="text" name="name" /></form>\n)
		end
	end
end
