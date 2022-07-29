module Phlex
  module Rails
    module Rendering
      def render(...)
        _raw ActionController::Base.new.render_to_string(...)
      end
    end
  end
end

Phlex::Context.include(Phlex::Rails::Rendering)
