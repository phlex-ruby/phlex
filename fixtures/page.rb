# frozen_string_literal: true

module Example
	class Page
		include Phlex::HTML

		def template
			render LayoutComponent.new do
				h1 { "Hi" }

				table id: "test", class: "a b c d e f g" do
					tr do
						td id: "test", class: "a b c d e f g" do
							span { "Hi" }
						end

						td id: "test", class: "a b c d e f g" do
							span { "Hi" }
						end

						td id: "test", class: "a b c d e f g" do
							span { "Hi" }
						end

						td id: "test", class: "a b c d e f g" do
							span { "Hi" }
						end

						td id: "test", class: "a b c d e f g" do
							span { "Hi" }
						end
					end
				end
			end
		end
	end
end
