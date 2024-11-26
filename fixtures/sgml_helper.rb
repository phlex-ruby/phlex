# frozen_string_literal: true

module SGMLHelper
	def phlex(component = Phlex::HTML, *a, **k, &)
		component.new(*a, **k).call do |e|
			e.instance_exec(&)
		end
	end
end
