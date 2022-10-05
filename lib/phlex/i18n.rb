# frozen_string_literal: true

module Phlex
	module I18n
		def translate(key, **options)
			::I18n.translate(key, **options)
		end

		alias_method :t, :translate
	end
end
