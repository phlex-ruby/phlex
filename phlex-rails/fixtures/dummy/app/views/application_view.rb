# frozen_string_literal: true

module Views
	class ApplicationView < Phlex::HTML
		include Rails.application.routes.url_helpers
		include Phlex::Translation
	end
end
