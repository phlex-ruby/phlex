# frozen_string_literal: true

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

		each_item do |record|
			collection_yielder(record) do |*args, **kwargs|
				view_template(*args, **kwargs)

				if @_first && render_headers?
					buffer << @_headers.map! { |value| escape(value) }.join(",") << "\n"
				end

				buffer << @_current_row.map! { |value| escape(value) }.join(",") << "\n"
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
		elsif header != @_headers[@_current_column_index]
			raise "Inconsistent header."
		end

		@_current_row << value
		@_current_column_index += 1
	end

	def each_item(&block)
		@_collection.each(&block)
	end

	def collection_yielder(record)
		yield(record)
	end

	def collection
		@_collection
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

	def escape(value)
		value = value.to_s

		if value.include?('"') || value.include?(",") || value.include?("\n")
			%("#{value.gsub('"', '""')}")
		else
			value
		end
	end
end
