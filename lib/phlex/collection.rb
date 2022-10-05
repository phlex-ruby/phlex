# frozen_string_literal: true

module Phlex
	module Collection
		def initialize(collection: nil, item: nil, index: nil, position: nil, first: nil, last: nil, collection_size: nil)
			unless collection || item
				@collection = []
			end

			if collection && item
				raise ArgumentError, "You can pass either a collection or an item as a keyword argument but not both."
			end

			if (@item = item)
				@index = index
				@position = position
				@first = first
				@last = last
				@collection_size = collection_size
			else
				@collection = collection
			end
		end

		def template(&)
			yield(self) if block_given?

			if @collection
				collection_template { yield_items }
			else
				item_template
			end
		end

		private

		def yield_items
			if @item
				raise ArgumentError, "You can only yield_items when rendering a collection. This instance is rendering an item."
			end

			@collection.each_with_index do |item, index|
				render self.class.new(
					item: item,
					index: index,
					first: (index == 0),
					last: (index == @collection.size - 1),
					position: (index + 1),
					collection_size: @collection.size
				)
			end
		end

		def first?
			raise ArgumentError if @collection

			@first
		end

		def last?
			raise ArgumentError if @collection

			@last
		end
	end
end
