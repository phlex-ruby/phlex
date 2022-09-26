# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
	with "ViewComponent renders a Phlex component" do
		let(:output) { CommentsController.render "index" }

		it "renders comments" do
			expect(output).to be ==
										%(<div>\n  <span>\n    Matz\n  </span>\n  <span>\n    hey, folks\n  </span>\n\n  \n  Hello, World from a ViewComponent!\n\n\n  \n    <p>Start Card A</p>\n    \n<article class=\"drop-shadow p-5 rounded\"><h3 class=\"font-bold\">Hello from A</h3></article></div>\n)
		end
	end

	with "Phlex component renders a ViewComponent" do
		let(:output) { CommentsController.render "show" }

		it "renders comments" do
			expect(output).to be ==
										%(<div>\n  <span>\n    _why\n  </span>\n  <span>\n    I&#39;m back\n  </span>\n\n  \n\n  \n    <p>Start Card A</p>\n    \n<article class=\"drop-shadow p-5 rounded\"><h3 class=\"font-bold\">Hello from A</h3></article></div>\n\n)
		end
	end
end
