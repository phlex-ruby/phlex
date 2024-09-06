# frozen_string_literal: true

class Phlex::SGML::SafeValue
	include Phlex::SGML::SafeObject

	def initialize(to_s)
		@to_s = to_s
	end

	attr_reader :to_s
end
