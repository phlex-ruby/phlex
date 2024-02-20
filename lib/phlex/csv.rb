# frozen_string_literal: true

class Phlex::CSV
	include Phlex::Callable

	def initialize(collection)
		@collection = collection
		@_headers = []
		@_current_row = []
		@_current_column_index = 0
		@_view_context = nil
		@_first = true
	end

	attr_reader :collection

	def call(buffer = +"", view_context: nil)
		@_view_context = view_context

		each_item do |record|
			collection_yielder(record) do |*args, **kwargs|
				view_template(*args, **kwargs)

				if @_first && render_headers?
					buffer << @_headers.join(",") << "\n"
				end

				buffer << @_current_row.join(",") << "\n"
				@_current_column_index = 0
				@_current_row.clear
			end

			@_first = false
		end

		buffer
	end

	def file_name
		nil
	end

	def content_type
		"text/csv"
	end

	private

	def column(header = nil, value)
		if @_first
			@_headers << escape(header)
		elsif header != @_headers[@_current_column_index]
			raise "Inconsistent header."
		end

		@_current_row << escape(value)
		@_current_column_index += 1
	end

	def each_item(&block)
		collection.each(&block)
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

	def trim_space?
		true
	end

	def escape_formulas?
		true
	end

	def helpers
		@_view_context
	end

	def render(renderable)
		renderable.call(view_context: @_view_context)
	end

	def escape(value)
		if trim_space?
			value = value.to_s.strip

			first_char = value[0]

			if first_char == "=" || first_char == "+" || first_char == "-" || first_char == "@"
				# Prefix a single quote to prevent Excel, Google Docs, etc. from interpreting the value as a formula
				# See https://owasp.org/www-community/attacks/CSV_Injection
				%("'#{value.gsub('"', '""')}")
			elsif value.include?('"') || value.include?(",") || value.include?("\n")
				%("#{value.gsub('"', '""')}")
			else
				value
			end
		else # In the case of non-trimmed values, we need to escape some extra characters
			first_char = value[0]

			if first_char == "=" || first_char == "+" || first_char == "-" || first_char == "@" || first_char == "\t" || first_char == "\n"
				# Prefix a single quote to prevent Excel, Google Docs, etc. from interpreting the value as a formula
				# See https://owasp.org/www-community/attacks/CSV_Injection
				%("'#{value.gsub('"', '""')}")
			elsif first_char == " " || value.include?('"') || value.include?(",") || value.include?("\n")
				%("#{value.gsub('"', '""')}")
			else
				value
			end
		end
	end
end
