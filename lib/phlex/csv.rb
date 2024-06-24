# frozen_string_literal: true

class Phlex::CSV
	include Phlex::Callable

	FORMULA_PREFIXES = Set["=", "+", "-", "@", "\t", "\r"].freeze
	SPACE_CHARACTERS = Set[" ", "\t", "\r"].freeze

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
		unless escape_csv_injection? == true || escape_csv_injection? == false
			raise <<~MESSAGE
				You need to define escape_csv_injection? in #{self.class.name}, returning either `true` or `false`.

				CSV injection is a security vulnerability where malicious spreadsheet formulae are used to execute code or exfiltrate data when a CSV is opened in a spreadsheet program such as Microsoft Excel or Google Sheets.

				For more information, see https://owasp.org/www-community/attacks/CSV_Injection

				If you're sure this CSV will never be opened in a spreadsheet program, you can disable CSV injection escapes:

				  def escape_csv_injection? = false

				This is useful when using CSVs for byte-for-byte data exchange between secure systems.

				Alternatively, you can enable CSV injection escapes at the cost of data integrity:

				  def escape_csv_injection? = true

				Note: Enabling the CSV injection escapes will prefix any values that start with `=`, `+`, `-`, `@`, `\\t`, or `\\r` with a single quote `'` to prevent them from being interpreted as formulae by spreadsheet programs.

				Unfortunately, there is no one-size-fits-all solution to CSV injection. You need to decide based on your specific use case.
			MESSAGE
		end

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

	def filename
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

	def each_item(&)
		collection.each(&)
	end

	def yielder(record)
		yield(record)
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
	def escape_csv_injection?
		nil
	end

	def helpers
		@_view_context
	end

	def escape(value)
		value = trim_whitespace? ? value.to_s.strip : value.to_s
		first_char = value[0]
		last_char = value[-1]

		if escape_csv_injection? && FORMULA_PREFIXES.include?(first_char)
			# Prefix a single quote to prevent Excel, Google Docs, etc. from interpreting the value as a formula.
			# See https://owasp.org/www-community/attacks/CSV_Injection
			%("'#{value.gsub('"', '""')}")
		elsif (!trim_whitespace? && (SPACE_CHARACTERS.include?(first_char) || SPACE_CHARACTERS.include?(last_char))) || value.include?('"') || value.include?(",") || value.include?("\n")
			%("#{value.gsub('"', '""')}")
		else
			value
		end
	end
end
