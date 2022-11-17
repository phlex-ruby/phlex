# frozen_string_literal: true

module Rspec
	module Generators
		class ViewGenerator < ::Rails::Generators::NamedBase
			source_root File.expand_path("templates", __dir__)

			def create_view
				@path = File.join("app/views", class_path, "#{file_name}.rb")
				template "view_spec.rb.erb", File.join("spec/views", class_path, "#{file_name}_spec.rb")
			end
		end
	end
end
