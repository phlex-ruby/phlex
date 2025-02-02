# frozen_string_literal: true

test "fetch caches the yield" do
	store = Phlex::FIFOCacheStore.new
	count = 0

	first_read = store.fetch("a") do
		count += 1
		"A"
	end

	assert_equal first_read, "A"
	assert_equal count, 1

	second_read = store.fetch("a") do
		failure! { "This block should not have been called." }
		"B"
	end

	assert_equal second_read, "A"
	assert_equal count, 1
end

test "nested caches do not lead to contention" do
	store = Phlex::FIFOCacheStore.new

	result = store.fetch("a") do
		[
			"A",
			store.fetch("b") { "B" },
		].join(", ")
	end

	assert_equal result, "A, B"
end

test "caching something other than a string" do
	store = Phlex::FIFOCacheStore.new

	assert_raises(ArgumentError) do
		store.fetch("a") { 1 }
	end
end
