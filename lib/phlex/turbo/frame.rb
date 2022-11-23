# frozen_string_literal: true

module Phlex
	module Turbo
		class Frame < Phlex::HTML
			include Experimental

			register_element :turbo_frame

			def initialize(src:, loading:, disabled:, target:, autoscroll:)
				@src = src
				@loading = loading
				@disabled = disabled
				@target = target
				@autoscroll = autoscroll
			end

			def template(&content)
				turbo_frame(src: @src, loading: @loading, disabled: @disabled, target: @target, autoscroll: @autoscroll, &content)
			end
		end
	end
end
