# frozen_string_literal: true

class Components::Article < Phlex::HTML
	def template(&block)
		article(&block)
	end
end
