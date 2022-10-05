# frozen_string_literal: true

module Phlex
	module Rails
		module Layout
			include Helpers::CSPMetaTag
			include Helpers::CSRFMetaTags
			include Helpers::ActionCableMetaTag
		end
	end
end
