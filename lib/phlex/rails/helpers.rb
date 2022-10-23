# frozen_string_literal: true

module Phlex
	module Rails
		module Helpers
			HELPERS = %w[csp_meta_tag csrf_meta_tags action_cable_meta_tag stylesheet_link_tag
				favicon_link_tag preload_link_tag javascript_include_tag link_to mail_to].freeze

			HELPERS.each do |name|
				class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        	# frozen_string_literal: true

					def #{name}(...)
						if (output = @_view_context.#{name}(...))
							@_target << output
						end
					end
				RUBY
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

			module ContentFor
				def content_for(slot, &block)
					@_view_context.content_for(slot, capture(&block))
				end
			end
		end
	end
end
