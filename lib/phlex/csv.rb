# frozen_string_literal: true

require "csv"

class Phlex::CSV
	include Phlex::Callable

	def initialize(collection)
		@_collection = collection
		@_headers = []
		@_current_row = []
		@_current_column_index = 0
		@_view_context = nil
		@_first = true
	end

	def call(buffer = +"", view_context: nil)
		@_view_context = view_context

		@_collection.each do |record|
			collection_yielder(record) do |*args, **kwargs|
				template(*args, **kwargs)

				if @_first && render_headers?
					buffer << ::CSV.generate_line(@_headers)
				end

				buffer << ::CSV.generate_line(@_current_row)
				@_current_column_index = 0
				@_current_row.clear
			end

			@_first = false
		end

		buffer
	end

	def filename
		nil
	end

	private

	def column(header = nil, value)
		if @_first
			@_headers << header
		else
			raise unless header == @_headers[@_current_column_index]
		end

		@_current_row << value
		@_current_column_index += 1
	end

	def collection_yielder(record)
		yield(record)
	end

	def template(...)
		nil
	end

	def render_headers?
		true
	end

	def helpers
		@_view_context
	end

	def render(renderable)
		renderable.call(view_context: @_view_context)
	end
end
