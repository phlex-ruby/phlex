# frozen_string_literal: true

module Phlex
	module Generators
		class ViewGenerator < ::Rails::Generators::NamedBase
			source_root File.expand_path("templates", __dir__)

			def create_view
				@layout = layout
				@path = File.join("app/views", class_path, "#{file_name}.rb")
				template "view.rb.erb", @path
			end

			private

			def layout
				Rails.root.join("app/views/layout.rb").exist?
			end
		end
	end
end
