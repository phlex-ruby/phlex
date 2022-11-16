# frozen_string_literal: true

module Phlex
	module Generators
		class TableGenerator < ::Rails::Generators::NamedBase
			source_root File.expand_path("templates", __dir__)
			class_option :properties, type: :array, default: []

			def create_view
				template "table.rb.erb", File.join("app/views", class_path, "#{file_name}.rb")
			end
		end
	end
end
