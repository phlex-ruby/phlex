# frozen_string_literal: true

Product = Struct.new(:name, :price)

class ProductsCSV < Phlex::CSV
	def view_template(product)
		column("name", product.name)
		column("price", product.price)
	end
end

describe Phlex::CSV do
	it "renders a CSV" do
		products = [
			Product.new("Apple", 1.00),
			Product.new("Banana", 2.00)
		]

		csv = ProductsCSV.new(products).call

		expect(csv).to be == <<~CSV
			name,price
			Apple,1.0
			Banana,2.0
		CSV
	end

	it "escapes commas" do
		product = Product.new("Apple, Inc.", 1.00)
		csv = ProductsCSV.new([product]).call

		expect(csv).to be == <<~CSV
			name,price
			"Apple, Inc.",1.0
		CSV
	end

	it "escapes newlines" do
		product = Product.new("Apple\nInc.", 1.00)
		csv = ProductsCSV.new([product]).call

		expect(csv).to be == <<~CSV
			name,price
			"Apple\nInc.",1.0
		CSV
	end

	it "escapes quotes" do
		product = Product.new("Apple\"Inc.", 1.00)
		csv = ProductsCSV.new([product]).call

		expect(csv).to be == <<~CSV
			name,price
			"Apple""Inc.",1.0
		CSV
	end

	class WithoutHeaders < ProductsCSV
		def render_headers?
			false
		end
	end

	it "renders without headers" do
		products = [
			Product.new("Apple", 1.00),
			Product.new("Banana", 2.00)
		]

		csv = WithoutHeaders.new(products).call

		expect(csv).to be == <<~CSV
			Apple,1.0
			Banana,2.0
		CSV
	end
end
