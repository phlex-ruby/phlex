# frozen_string_literal: true

module Phlex
	module Rails
		module Helpers
			module CSPMetaTag
				def csp_meta_tag
					if (output = @_view_context.csp_meta_tag)
						@_target << output
					end
				end
			end

			module CSRFMetaTags
				def csrf_meta_tags
					if (output = @_view_context.csrf_meta_tags)
						@_target << output
					end
				end
			end

			module ActionCableMetaTag
				def action_cable_meta_tag
					if (output = @_view_context.action_cable_meta_tag)
						@_target << output
					end
				end
			end

			module FormWith
				def form_with(*args, **kwargs, &block)
					raw @_view_context.form_with(*args, **kwargs) { |form|
						capture do
							yield(
								Phlex::Buffered.new(form, buffer: @_target)
							)
						end
					}
				end
			end
		end
	end
end
