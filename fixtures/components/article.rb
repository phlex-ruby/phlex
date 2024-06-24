# frozen_string_literal: true

class Components::Article < Phlex::HTML
	def view_template(&)
		article(&)
	end
end
