# frozen_string_literal: true

module Phlex
	module Collection
		def initialize(collection: nil, item: nil)
			unless collection || item
				raise ArgumentError, "You must pass a collection or an item as a keyword argument."
			end

			@collection = collection
			@item = item
		end

		def template
			if @item
				item_template
			else
				collection_template { yield_items }
			end
		end

		private

		def yield_items
			if @item
				raise ArgumentError, "You can only yield_items when rendering a collection. You are currently rendering an item."
			end

			@collection.each_with_index do |item, index|
				@item = item
				@index = index
				@position = (index + 1)
				@first = (index == 0)
				@last = (@position == @collection.size)

				item_template
			end

			@item = nil
			@index = nil
			@first = nil
			@last = nil
			@position = nil
		end

		def first?
			raise ArgumentError unless @item

			!!@first
		end

		def last?
			raise ArgumentError unless @item

			!!@last
		end
	end
end
