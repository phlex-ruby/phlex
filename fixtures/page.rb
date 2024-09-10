# frozen_string_literal: true

module Example
	extend Phlex::Kit
	class Page < Phlex::HTML
		def view_template
			LayoutComponent do
				h1 { "Hi" }

				100.times do
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
end
