# frozen_string_literal: true

module Example
	class Page < Phlex::View
		def template
			render LayoutComponent.new do
				h1 "Hi"

				5.times do
					div do
						10.times do
							a "Test", href: "something", unique: SecureRandom.uuid, data: { value: 1 }
						end
					end
				end

				table do
					thead do
						10.times do
							tr do
								th "Hi"
							end
						end
					end

					tbody do
						100.times do
							tr class: "a b c d e f g", id: "something" do
								10.times do
									td class: "f g h i j k l" do
										span "Test"
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
