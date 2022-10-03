# frozen_string_literal: true

module Phlex
	class Collection < Phlex::View
		def initialize(collection: nil, item: nil)
			unless collection || item
				raise ArgumentError,
					"You must pass a collection or an item as a keyword argument."
			end

			if collection && item
				raise ArgumentError,
					"You can pass either a collection or an item as a keyword argument but not both."
			end

			@collection = collection or @item = item
		end

		def template
			@collection ? collection_template : item_template
		end

		private

		def yield_items
			if @item
				raise NoMethodError,
					"You can only yield_items when rendering a collection. You're already rendering an item."
			end

			@collection.each do |item|
				render self.class.new(item: item)
			end
		end
	end
end
