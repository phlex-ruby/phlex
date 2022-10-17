# frozen_string_literal: true

module Components
	class Tabs < Phlex::View
		def initialize
			@index = 1
		end

		def template(&block)
			div class: "tabs flex flex-wrap relative my-5", role: "tablist" do
				yield_content(&block)
			end
		end

		def tab(name, &block)
			Tab name: name, checked: first?, &block
			@index += 1
		end

		def unique_identifier
			@unique_identifier ||= SecureRandom.hex
		end

		private

		def first?
			@index == 1
		end
	end
end
