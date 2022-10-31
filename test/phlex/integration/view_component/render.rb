# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	with "ViewComponent renders a Phlex component" do
		let(:output) { CommentsController.render "index" }

		it "renders comments" do
			expect(output).to be ==
				%(<div>\n  <span>\n    Matz\n  </span>\n  <span>\n    hey, folks\n  </span>\n\n  \n  Hello, World from a ViewComponent!\n\n\n  \n    <p>Emoji reaction for a comment from Matz with body hey, folks</p>\n<p>hamburger</p>&lt;/p&gt;\n</div>\n)
		end
	end

	with "Phlex component renders a ViewComponent" do
		let(:output) { CommentsController.render "show" }

		it "renders comments" do
			expect(output).to be ==
				%(<div><span>_why</span><span>I&#39;m back</span>\n  Hello, World from a Phlex Component!\n<p>Emoji reaction for a comment from _why with body I&#39;m back</p><p>hamburger</p>\n\n\n</div>)
		end
	end
end
