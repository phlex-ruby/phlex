# frozen_string_literal: true

say "Installing Phlex..."

application_configuration_path = Rails.root.join("config/application.rb")
application_configuration_content = File.read(application_configuration_path)

pattern = %r(config.autoload_paths << (Rails.root.join\(.app.\)|.\#{root}/app.)\n)

unless application_configuration_content.match?(pattern)
	inject_into_class(
		application_configuration_path,
		"Application",
		%(    config.autoload_paths << "\#{root}/app"\n)
	)
end

unless Rails.root.join("app/views/application_view.rb").exist?
	create_file(Rails.root.join("app/views/application_view.rb"), <<~RUBY)
		# frozen_string_literal: true

		module Views
		  class ApplicationView < Phlex::View
		    include Rails.application.routes.url_helpers
		    include Phlex::Translation
		  end
		end
	RUBY
end

tailwind_config_path = Rails.root.join("config/tailwind.config.js")

if tailwind_config_path.exist?
	insert_into_file tailwind_config_path, after: "content: [" do
		"\n    './app/views/**/*.rb',"
	end
end

say "Phlex successfully installed!"
