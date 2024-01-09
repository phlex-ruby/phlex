# frozen_string_literal: true

module Phlex
	# @abstract Subclass and define {#template} to create an HTML component class.
	class HTML
		include Renderable
		include HtmlRenderable
	end
end
