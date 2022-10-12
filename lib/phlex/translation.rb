# frozen_string_literal: true

module Phlex
	module Translation
		def self.included(view)
			view.extend(ClassMethods)
		end

		module ClassMethods
			attr_writer :translation_path

			def translation_path
				@translation_path ||= name&.split("::")&.join(".")&.downcase.to_s
			end
		end

		def translate(key, **options)
			key = "#{self.class.translation_path}#{key}" if key.start_with?(".")

			::I18n.translate(key, **options)
		end

		alias_method :t, :translate
	end
end
