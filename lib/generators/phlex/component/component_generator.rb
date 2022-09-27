# frozen_string_literal: true

module Phlex
	module Generators
		class ComponentGenerator < ::Rails::Generators::NamedBase
			source_root File.expand_path("templates", __dir__)

			def create_view
				template "component.rb.erb", File.join("app/views", class_path, "#{file_name}.rb")
			end
		end
	end
end
