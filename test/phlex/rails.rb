# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	with "rendered in an ERB view" do
		let(:output) { ArticlesController.render "index" }

		it "renders the correct output" do
			expect(output).to be ==
				%(<p>Before</p>\n\n<h1>Hello World!</h1>\n\n<article class=\"drop-shadow p-5 rounded\">\n  <p>Start Card A</p>\n  <h3 class=\"font-bold\">Hello from A</h3>\n  <article class=\"drop-shadow p-5 rounded\">\n    <p>Start Card B</p>\n    <h3 class=\"font-bold\">Hello from B</h3>\n    <p>End Card B</p>\n</article>  <p>End Card A</p>\n</article>)
		end
	end
end
