# frozen_string_literal: true

class Phlex::CSV
	include Phlex::Callable

	FORMULA_PREFIXES = ["=", "+", "-", "@", "\t", "\r"].to_h { |prefix| [prefix, true] }.freeze
	SPACE_CHARACTERS = [" ", "\t", "\r"].to_h { |char| [char, true] }.freeze

	module InjectionPolicy
		Raise = lambda do |value|
			raise "CSV injection detected: #{value.inspect}"
		end

		Ignore = lambda do |value|
			value
		end

		Escape = lambda do |value|
			%("'#{value.gsub('"', '""')}")
		end
	end

	include InjectionPolicy

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
			yielder(record) do |*args, **kwargs|
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

	def yielder(record)
		yield(record)
	end

	def template(...)
		nil
	end

	# Override and set to `false` to disable rendering headers.
	def render_headers?
		true
	end

	# Override and set to `true` to strip leading and trailing whitespace from values.
	def trim_whitespace?
		false
	end

	# Override and set to `false` to disable CSV injection escapes or `true` to enable.
	def in_case_of_injection
		Raise
	end

	def helpers
		@_view_context
	end

	def escape(value)
		value = trim_whitespace? ? value.to_s.strip : value.to_s
		first_char = value[0]
		last_char = value[-1]

		if InjectionPolicy::Ignore != in_case_of_injection && FORMULA_PREFIXES[first_char]
			in_case_of_injection.call(value)
		elsif (!trim_whitespace? && (SPACE_CHARACTERS[first_char] || SPACE_CHARACTERS[last_char])) || value.include?('"') || value.include?(",") || value.include?("\n")
			%("#{value.gsub('"', '""')}")
		else
			value
		end
	end
end
