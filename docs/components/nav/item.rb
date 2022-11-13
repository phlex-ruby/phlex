# frozen_string_literal: true

module Components
	class Nav::Item < Phlex::HTML
		def initialize(text, to:, active_page:)
			@text = text
			@to = to
			@active_page = active_page
		end

		def template
			li do
				a(**link_classes, href: "/#{link}") { @text }
			end
		end

		def link_classes
			classes("pb-1 block font-medium text-stone-500", active?: "text-red-600 font-bold")
		end

		def link
			path == "index" ? "" : path
		end

		def path
			@to.name.split("::")[1..].map { _1.gsub(/(.)([A-Z])/, '\1-\2') }.map(&:downcase).join("/")
		end

		def active?
			@active_page.instance_of?(@to)
		end
	end
end
