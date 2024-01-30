# frozen_string_literal: true

module Phlex
	module BasicEscape
		def html_escape(string)
			string
				.dup
				.gsub!("&", "&amp;")
				.gsub!("<", "&lt;")
				.gsub!(">", "&gt;")
				.gsub!('"', "&quot;")
				.gsub!("'", "&#39;")
				.freeze
		end
	end
end
