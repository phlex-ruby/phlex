# frozen_string_literal: true

module Components
	class Tabs < Phlex::View
		def initialize
			@index = 1
		end

		def template(&)
			div class: "tabs flex flex-wrap relative my-5", role: "tablist" do
				yield_content(&)
			end
		end

		def tab(name, &)
			render(Tab.new(name:, checked: first?), &)
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
