# frozen_string_literal: true

module Phlex
	module Generators
		class ControllerGenerator < ::Rails::Generators::NamedBase # :nodoc:
			source_root File.expand_path("templates", __dir__)

			argument :actions, type: :array, default: [], banner: "action action"
			class_option :skip_routes, type: :boolean, desc: "Don't add routes to config/routes.rb."
			class_option :parent, type: :string, default: "ApplicationController", desc: "The parent class for the generated controller"

			check_class_collision suffix: "Controller"

			def create_controller_files
				template "controller.rb.erb", File.join("app/controllers", class_path, "#{file_name}_controller.rb")
			end

			def copy_view_files
				base_path = File.join("app/views", class_path, file_name)
				empty_directory base_path

				actions.each do |action|
					Rails::Generators.invoke("phlex:view", [remove_possible_suffix(name) + "/" + action])
				end
			end

			def add_routes
				return if options[:skip_routes]
				return if actions.empty?

				routing_code = actions.map { |action| "get '#{file_name}/#{action}'" }.join("\n")
				route routing_code, namespace: regular_class_path
			end

			hook_for :test_framework, as: :controller do |generator|
				invoke generator, [remove_possible_suffix(name), actions]
			end

			private

			def parent_class_name
				options[:parent]
			end

			def file_name
				@_file_name ||= remove_possible_suffix(super)
			end

			def remove_possible_suffix(name)
				name.sub(/_?controller$/i, "")
			end
		end
	end
end
