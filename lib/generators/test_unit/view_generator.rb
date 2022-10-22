# frozen_string_literal: true

module TestUnit
	class ViewGenerator < ::Rails::Generators::NamedBase
		source_root File.expand_path("templates", __dir__)

		def create_view
			template "view_test.rb.erb", File.join("test/views", class_path, "#{file_name}_test.rb")
		end
	end
end
