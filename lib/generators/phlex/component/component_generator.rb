module Phlex
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_component
        template "component.rb", File.join("app/views/components", class_path, "#{file_name}_component.rb")
      end
    end
  end
end
