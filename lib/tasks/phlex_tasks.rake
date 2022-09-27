# frozen_string_literal: true

namespace :phlex do
	desc "Install Phlex in the Rails application"
	task :install do
		install_file_path = File.expand_path("../install/phlex.rb", __dir__)

		system "#{RbConfig.ruby} bin/rails app:template LOCATION=#{install_file_path}"
	end
end
