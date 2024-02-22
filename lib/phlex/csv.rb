# frozen_string_literal: true

class Phlex::CSV
	include Phlex::Callable

	autoload :InjectionError, "phlex/csv/injection_error"

	FORMULA_PREFIXES = ["=", "+", "-", "@", "\t", "\r"].to_h { |prefix| [prefix, true] }.freeze
	SPACE_CHARACTERS = [" ", "\t", "\r"].to_h { |char| [char, true] }.freeze

	def initialize(collection)
		@collection = collection
		@_headers = []
		@_current_row = []
		@_current_column_index = 0
		@_view_context = nil
		@_first = true
		@_escape_csv_injection_arity = nil
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
	def escape_csv_injection?(value = nil, column_header = nil)
		raise InjectionError, value, column_header
	end

	def helpers
		@_view_context
	end

	def escape(value)
		value = trim_whitespace? ? value.to_s.strip : value.to_s
		first_char = value[0]
		last_char = value[-1]

		if FORMULA_PREFIXES[first_char] && _escape_csv_injection?(value)
			# Prefix a single quote to prevent Excel, Google Docs, etc. from interpreting the value as a formula.
			# See https://owasp.org/www-community/attacks/CSV_Injection
			%("'#{value.gsub('"', '""')}")
		elsif (!trim_whitespace? && (SPACE_CHARACTERS[first_char] || SPACE_CHARACTERS[last_char])) || value.include?('"') || value.include?(",") || value.include?("\n")
			%("#{value.gsub('"', '""')}")
		else
			value
		end
	end

	def _escape_csv_injection?(value)
		case _escape_csv_injection_arity
		when 0 then escape_csv_injection?
		when 1 then escape_csv_injection?(value)
		else
			escape_csv_injection?(value, @_headers[@_current_column_index])
		end
	end

	def _escape_csv_injection_arity
		@_escape_csv_injection_arity ||= method(:escape_csv_injection?).arity.abs
	end
end
