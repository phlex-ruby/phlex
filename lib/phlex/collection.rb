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
			@item ? item_template : collection_template { yield_items }
		end

		private

		def yield_items
			if @item
				raise ArgumentError, "You can only yield_items when rendering a collection. You are currently rendering an item."
			end

			@collection.each do |item|
				@item = item
				item_template
			end

			@item = nil
		end
	end
end
