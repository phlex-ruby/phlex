# frozen_string_literal: true

require "rails/engine"

module Phlex
	class Engine < ::Rails::Engine
		initializer "phlex.tag_helpers" do
			Phlex::Component.include(Phlex::Rails::TagHelpers)
		end
	end
end
