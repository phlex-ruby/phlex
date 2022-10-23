# frozen_string_literal: true

module Views
	class LinkHomeWithImage < Phlex::View
		include Phlex::Rails::Helpers

		def template
			link_to :root, class: "link" do
				text "Go Back Home"
				img src: "/go/back.gif"
			end
		end
	end
end
