# frozen_string_literal: true

module Views
	class LinkHome < Phlex::View
		include Phlex::Rails::Helpers

		def template
			link_to "Go Back Home", :root
		end
	end
end
