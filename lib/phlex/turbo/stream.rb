# frozen_string_literal: true

module Phlex
	module Turbo
		class Stream < Phlex::HTML
			register_element :turbo_stream

			def initialize(action:, **attributes)
				@action = action
				@attributes = attributes
			end

			def template(&content)
				turbo_stream(action: @action, **@attributes, &content)
			end
		end
	end
end
