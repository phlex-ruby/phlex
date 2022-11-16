# frozen_string_literal: true

module Phlex
	class Configuration
		attr_reader :form_with_custom_methods

		def initialize
			@form_with_custom_methods = []
		end

		def form_with_custom_methods=(custom_methods)
			@form_with_custom_methods = custom_methods
			@form_with_custom_methods.each do |method_name|
				Phlex::Rails::Helpers::FormWith::BufferedFormWith.alias_method method_name, :__output_method__
			end
		end
	end
end
