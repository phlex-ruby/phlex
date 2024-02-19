# frozen_string_literal: true

module Phlex::Renderable
	def call(buffer = +"", context: Phlex::Context.new, view_context:, parent: nil)
		raise NoMethodError, "The method `call` must be implemented."
	end
end
