# frozen_string_literal: true

module Example
	class Page < Phlex::HTML
		def initialize(products: [])
			@products = products
		end

		def template
			render LayoutComponent.new do
				h1 { "Hi" }

				table id: "test", class: "a b c d e f g" do
					@products.each_with_index do |product, index|
						tr id: index do
							td id: [index, "name"].join("-"), class: "a b c d e f g" do
								product.name
							end
							td id: [index, "price"].join("-"), class: "a b c d e f g" do
								product.price
							end
							td id: [index, "color"].join("-"), class: "a b c d e f g", style: "background-color: #{product.color};" do
								product.color
							end
						end
					end
				end
			end
		end
	end
end
