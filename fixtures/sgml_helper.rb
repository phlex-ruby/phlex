# frozen_string_literal: true

module SGMLHelper
	def phlex(component = Phlex::HTML, *, **, &)
		component.new(*, **).call do |e|
			e.instance_exec(&)
		end
	end
end
