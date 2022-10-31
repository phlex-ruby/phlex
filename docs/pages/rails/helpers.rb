# frozen_string_literal: true

module Pages
	module Rails
		class Helpers < ApplicationPage
			def template
				render Layout.new(title: "Using Rails helpers in Phlex views") do
					render Markdown.new <<~MD
						# Using Rails helpers in Phlex views

						## The `helpers` proxy

						You can use the `helpers` proxy to access any Rails helper from a Phlex view. For example, you can use the `#t` helper for translations:

						```ruby
						module Views
							class Hello < ApplicationView
								delegate :t, to: :helpers

								def template
									h1 do
										t "hello"
									end
								end
							end
						end
						```

						## Layout helpers

						Rails tag helpers return strings which makes them less than ideal to use from Phlex. Including `Phlex::Rails::Layout` gives you access to the following Rails helper proxies which immediately output to the buffer:

						#{(Phlex::Rails::Layout.instance_methods - Module.methods).sort.map { "1. `#{_1}`" }.join("\n")}

						Using these is equvalent to passing the output of the original Rails helpers to `raw`, e.g:

						```ruby
						unsafe_raw helpers.javascript_include_tag
						```

						## Including proxies

						The following modules can be included for direct access to these helpers:

						#{Phlex::Rails::Helpers.constants.sort.map { "1. `Phlex::Rails::Helpers::#{_1}`" }.join("\n")}

						Note, helpers that produce HTML are adapted to output to the buffer directly.
					MD
				end
			end
		end
	end
end
