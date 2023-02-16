# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Phlex::Overrides::Symbol::Name
end

module Phlex
	class SVG < XML
		include StandardElements

		def template
			yield
		end
	end
end
