# frozen_string_literal: true

Product = Struct.new(:name, :price)

class Base < Phlex::CSV
	def row_template(product)
		column("name", product.name)
		column("price", product.price)
	end
end

products = [
	Product.new("Apple", 1.00),
	Product.new(" Banana ", 2.00),
	Product.new(:strawberry, "Three pounds"),
	Product.new("=SUM(A1:B1)", "=SUM(A1:B1)"),
	Product.new("Abc, \"def\"", "Foo\nbar \"baz\""),
]

test "don’t escape csv injection or trim whitespace" do
	example = Class.new(Base) do
		define_method(:escape_csv_injection?) { false }
		define_method(:trim_whitespace?) { false }
	end

	assert_equal example.new(products).call, <<~CSV
		name,price
		Apple,1.0
		" Banana ",2.0
		strawberry,Three pounds
		=SUM(A1:B1),=SUM(A1:B1)
		"Abc, ""def""","Foo\nbar ""baz"""
	CSV
end

test "don’t escape csv injection, but do trim whitespace" do
	example = Class.new(Base) do
		define_method(:escape_csv_injection?) { false }
		define_method(:trim_whitespace?) { true }
	end

	assert_equal example.new(products).call, <<~CSV
		name,price
		Apple,1.0
		Banana,2.0
		strawberry,Three pounds
		=SUM(A1:B1),=SUM(A1:B1)
		Abc, "def",Foo\nbar "baz"
	CSV
end

test "escape csv injection, but don’t trim whitespace" do
	example = Class.new(Base) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { false }
	end

	assert_equal example.new(products).call, <<~CSV
		name,price
		Apple,1.0
		" Banana ",2.0
		strawberry,Three pounds
		"'=SUM(A1:B1)","'=SUM(A1:B1)"
		"Abc, ""def""","Foo
		bar ""baz"""
	CSV
end

test "escape csv injection and trim whitespace" do
	example = Class.new(Base) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { true }
	end

	assert_equal example.new(products).call, <<~CSV
		name,price
		Apple,1.0
		Banana,2.0
		strawberry,Three pounds
		"'=SUM(A1:B1)","'=SUM(A1:B1)"
		"Abc, ""def""","Foo
		bar ""baz"""
	CSV
end

test "no headers" do
	example = Class.new(Base) do
		define_method(:render_headers?) { false }
		define_method(:escape_csv_injection?) { false }
	end

	assert_equal example.new(products).call, <<~CSV
		Apple,1.0
		" Banana ",2.0
		strawberry,Three pounds
		=SUM(A1:B1),=SUM(A1:B1)
		"Abc, ""def""","Foo
		bar ""baz"""
	CSV
end

test "using view_template instead of row_template" do
	example = Class.new(Phlex::CSV) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { true }

		define_method(:view_template) do |product|
			column "Name", product.name
			column "Price", product.price
		end
	end

	component = example.new(products)
	assert component.respond_to?(:row_template)

	assert_raises(NoMethodError) do
		component.some_random_method
	end

	assert_equal component.call, <<~CSV
		Name,Price
		Apple,1.0
		Banana,2.0
		strawberry,Three pounds
		"'=SUM(A1:B1)","'=SUM(A1:B1)"
		"Abc, ""def""","Foo
		bar ""baz"""
	CSV
end

test "with a yielder" do
	example = Class.new(Phlex::CSV) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { true }
		define_method(:yielder) { |product, &block| block.call(product.name, product.price) }
		define_method(:row_template) do |name, price|
			column "Name", name
			column "Price", price
		end
	end

	assert_equal example.new(products).call, <<~CSV
		Name,Price
		Apple,1.0
		Banana,2.0
		strawberry,Three pounds
		"'=SUM(A1:B1)","'=SUM(A1:B1)"
		"Abc, ""def""","Foo
		bar ""baz"""
	CSV
end

test "with a custom delimiter defined as a method" do
	example = Class.new(Phlex::CSV) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { true }
		define_method(:delimiter) { ";" }
		define_method(:row_template) do |product|
			column "Name", product.name
			column "Price", product.price
		end
	end

	assert_equal example.new(products).call, <<~CSV
		Name;Price
		Apple;1.0
		Banana;2.0
		strawberry;Three pounds
		"'=SUM(A1:B1)";"'=SUM(A1:B1)"
		"Abc, ""def""";"Foo
		bar ""baz"""
	CSV
end

test "with a custom delimiter passed in as an argument" do
	example = Class.new(Phlex::CSV) do
		define_method(:escape_csv_injection?) { true }
		define_method(:trim_whitespace?) { true }
		define_method(:row_template) do |product|
			column "Name", product.name
			column "Price", product.price
		end
	end

	assert_equal example.new(products).call(delimiter: ";"), <<~CSV
		Name;Price
		Apple;1.0
		Banana;2.0
		strawberry;Three pounds
		"'=SUM(A1:B1)";"'=SUM(A1:B1)"
		"Abc, ""def""";"Foo
		bar ""baz"""
	CSV
end

test "with an invalid custom delimiter" do
	example = Class.new(Base) do
		define_method(:escape_csv_injection?) { true }
	end

	error = assert_raises(Phlex::ArgumentError) do
		example.new([]).call(delimiter: "invalid")
	end

	assert_equal error.message, "Delimiter must be a single character"
end

test "content type" do
	assert_equal Base.new([]).content_type, "text/csv"
end

test "filename is nil by default" do
	assert_equal Base.new([]).filename, nil
end

test "raises an error if there's no escape plan" do
	error = assert_raises(RuntimeError) do
		Base.new([]).call
	end

	assert_includes error.message, "escape_csv_injection?"
end
