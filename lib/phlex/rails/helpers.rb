# frozen_string_literal: true

module Phlex
	module Rails
		module Helpers
			HELPERS = %w[csp_meta_tag csrf_meta_tags action_cable_meta_tag stylesheet_link_tag
				favicon_link_tag preload_link_tag javascript_include_tag link_to mail_to form_with].freeze

			HELPERS.each do |name|
				class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
					# frozen_string_literal: true

					def #{name}(*args, **kwargs, &block)
						if block_given?
							raw @_view_context.#{name}(*args, **kwargs) { |x|
								capture do
									yield Phlex::Buffered.new(x, buffer: @_target)
								end
							}
						else
							if (output = @_view_context.#{name}(*args, **kwargs))
								@_target << output
							end
						end
					end
				RUBY
			end

			module ContentFor
				def content_for(slot, &block)
					@_view_context.content_for(slot, capture(&block))
				end
			end
		end
	end
end
