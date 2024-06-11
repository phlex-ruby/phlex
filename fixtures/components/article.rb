# frozen_string_literal: true

class Components::Article < Phlex::HTML
	def view_template(&block)
		article(&block)
	end
end
