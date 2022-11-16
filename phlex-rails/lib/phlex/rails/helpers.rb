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
				class BufferedFormWith < Phlex::Buffered
					alias_method :check_box, :__output_method__
					alias_method :collection_check_boxes, :__output_method__
					alias_method :collection_radio_buttons, :__output_method__
					alias_method :collection_select, :__output_method__
					alias_method :color_field, :__output_method__
					alias_method :date_field, :__output_method__
					alias_method :date_select, :__output_method__
					alias_method :datetime_field, :__output_method__
					alias_method :datetime_local_field, :__output_method__
					alias_method :datetime_select, :__output_method__
					alias_method :email_field, :__output_method__
					alias_method :file_field, :__output_method__
					alias_method :grouped_collection_select, :__output_method__
					alias_method :hidden_field, :__output_method__
					alias_method :label, :__output_method__
					alias_method :month_field, :__output_method__
					alias_method :number_field, :__output_method__
					alias_method :password_field, :__output_method__
					alias_method :phone_field, :__output_method__
					alias_method :radio_button, :__output_method__
					alias_method :range_field, :__output_method__
					alias_method :search_field, :__output_method__
					alias_method :select, :__output_method__
					alias_method :submit, :__output_method__
					alias_method :telephone_field, :__output_method__
					alias_method :text_area, :__output_method__
					alias_method :text_field, :__output_method__
					alias_method :time_field, :__output_method__
					alias_method :time_select, :__output_method__
					alias_method :time_zone_select, :__output_method__
					alias_method :url_field, :__output_method__
					alias_method :week_field, :__output_method__
					alias_method :weekday_select, :__output_method__
					alias_method :button, :__output_method__
				end

				def form_with(*args, **kwargs, &block)
					@_target << @_view_context.form_with(*args, **kwargs) { |form|
						capture do
							yield(
								BufferedFormWith.new(form, buffer: @_target)
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

			module JavaScriptImportmapTags
				def javascript_importmap_tags
					if (output = @_view_context.javascript_importmap_tags)
						@_target << output
					end
				end
			end

			module ContentFor
				def content_for(slot, &block)
					@_view_context.content_for(slot, capture(&block))
				end
			end
		end
	end
end
