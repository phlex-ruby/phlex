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

  class Views::ApplicationView < Phlex::View
    # Base class for your views
  end
	RUBY
end

say "Phlex successfully installed!"
