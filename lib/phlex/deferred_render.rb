# frozen_string_literal: true

# Include this module into an {HTML} or {SVG} component to make it yield the content block before calling {#template}.
# @example
# 	class Tabs < Phlex::HTML
# 		include DeferredRender
#
# 		Tab = Data.define(:name, :content)
#
# 		def initialize
# 			@tabs = []
# 		end
#
# 		def view_template
# 			@tabs.each { |t| a { t.name } }
# 			@tabs.each { |t| article(&t.content) }
# 		end
#
# 		def tab(name, &content)
# 			@tabs << Tab.new(name, content)
# 		end
# 	end
module Phlex::DeferredRender
	# This module doesn't do anything. Phlex::HTML#call checks for its inclusion in the ancestry instead.

	# @!method template
	# @abstract Override to define your own template.
	# @note {DeferredRender} templates do not receive the content block. Instead, it is yielded in advance.
end
