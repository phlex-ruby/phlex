# frozen_string_literal: true

Product = Struct.new(:name, :price)

class Base < Phlex::CSV
	def view_template(product)
		column("name", product.name)
		column("price", product.price)
	end
end

class Example < Base
	def escape_csv_injection?
		false
	end
end

class TrimWhitespace < Example
	def trim_whitespace?
		true
	end
end

class EscapeCSVInjection < Example
	def escape_csv_injection?
		true
	end
end

class NoHeaders < Example
	def render_headers?
		false
	end
end

test "basic csv" do
	products = [
		Product.new("Apple", 1.00),
		Product.new(" Banana ", 2.00),
	]

	expect(Example.new(products).call) == <<~CSV
		name,price
		Apple,1.0
		" Banana ",2.0
	CSV
end

test "trim whitespace" do
	products = [
		Product.new(" Apple", 1.00),
		Product.new("Banana ", 2.00),
	]

	expect(TrimWhitespace.new(products).call) == <<~CSV
		name,price
		Apple,1.0
		Banana,2.0
	CSV
end

test "escape csv injection" do
	products = [
		Product.new("Apple", "=SUM(A1:B1)"),
		Product.new("Banana", "+C2"),
	]

	expect(EscapeCSVInjection.new(products).call) == <<~CSV
		name,price
		Apple,"'=SUM(A1:B1)"
		Banana,"'+C2"
	CSV
end

test "no headers" do
	products = [
		Product.new("Apple", 1.00),
		Product.new("Banana", 2.00),
	]

	expect(NoHeaders.new(products).call) == <<~CSV
		Apple,1.0
		Banana,2.0
	CSV
end

test "content type" do
	expect(Example.new([]).content_type) == "text/csv"
end

test "raises an error if there's no escape plan" do
	expect { Base.new([]).call }.to_raise
end
