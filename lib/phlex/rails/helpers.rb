# frozen_string_literal: true

module Phlex
	module Rails
		module Helpers
			module CSPMetaTag
				def csp_meta_tag(**options)
					if (output = @_view_context.csp_meta_tag(**options))
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
				def form_with(*args, **kwargs, &)
					raw @_view_context.form_with(*args, **kwargs) { |form|
						capture do
							yield(
								Phlex::Buffered.new(form, buffer: @_target)
							)
						end
					}
				end
			end

			module StylesheetLinkTag
				def stylesheet_link_tag(*sources)
					if (output = @_view_context.stylesheet_link_tag(*sources))
						@_target << output
					end
				end
			end

			module FaviconLinkTag
				def favicon_link_tag(*args)
					if (output = @_view_context.favicon_link_tag(*args))
						@_target << output
					end
				end
			end

			module PreloadLinkTag
				def preload_link_tag(*args)
					if (output = @_view_context.preload_link_tag(*args))
						@_target << output
					end
				end
			end

			module JavaScriptIncludeTag
				def javascript_include_tag(*sources)
					if (output = @_view_context.javascript_include_tag(*sources))
						@_target << output
					end
				end
			end

			module ContentFor
				def content_for(slot, &)
					@_view_context.content_for(slot, capture(&))
				end
			end
		end
	end
end
