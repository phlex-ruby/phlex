# frozen_string_literal: true

class Phlex::CSV
	FORMULA_PREFIXES_MAP = Array.new(128).tap do |map|
		"=+-@\t\r".each_byte do |byte|
			map[byte] = true
		end
	end.freeze

	UNDEFINED = Object.new

	def initialize(collection, delimiter: ",")
		@collection = collection
		@delimiter = delimiter
		@_row_buffer = []
	end

	attr_reader :collection

	def call(buffer = +"", context: nil)
		ensure_escape_csv_injection_configured!

		strip_whitespace = trim_whitespace?
		escape_csv_injection = escape_csv_injection?
		delimiter = @delimiter
		row_buffer = @_row_buffer
		has_yielder = respond_to?(:yielder, true)
		first_row = true

		each_item do |record|
			if has_yielder
				row = nil
				yielder(record) { |*a, **k| row = around_row(*a, **k) }
			else
				row = around_row(record)
			end

			buffered = row_buffer.length > 0 # column was called
			row = row_buffer if buffered

			if first_row
				first_row = false

				if render_headers?
					i = 0
					number_of_columns = row.length
					first_col = true

					while i < number_of_columns
						header, = row[i]
						if first_col
							first_col = false
						else
							buffer << delimiter
						end

						__escape__(buffer, header, escape_csv_injection:, strip_whitespace:)
						i += 1
					end

					buffer << "\n"
				end
			end

			i = 0
			number_of_columns = row.length
			first_col = true

			while i < number_of_columns
				header, value = row[i]
				if first_col
					first_col = false
				else
					buffer << delimiter
				end

				__escape__(buffer, value, escape_csv_injection:, strip_whitespace:)
				i += 1
			end

			buffer << "\n"

			row_buffer.clear if buffered
		end

		buffer
	end

	def around_row(item)
		row_template(item)
	end

	def filename
		nil
	end

	def content_type
		"text/csv"
	end

	private

	def column(header = nil, value)
		@_row_buffer << [header, value]
	end

	def each_item(&)
		collection.each(&)
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
		UNDEFINED
	end

	def __escape__(buffer, value, escape_csv_injection:, strip_whitespace:)
		value = case value
		when String
			value
		when Symbol
			value.name
		else
			value.to_s
		end

		if strip_whitespace
			value = value.strip

			if escape_csv_injection
				if FORMULA_PREFIXES_MAP[value.getbyte(0)]
					value.gsub!('"', '""')
					buffer << '"\'' << value << '"'
				elsif value.match?(/[\n",]/)
					value.gsub!('"', '""')
					buffer << '"' << value << '"'
				else
					buffer << value
				end
			else # not escaping CSV injection
				buffer << value
			end
		else # not stripping whitespace
			if escape_csv_injection
				first_byte = value.getbyte(0)

				if FORMULA_PREFIXES_MAP[first_byte]
					buffer << '"\'' << value.gsub('"', '""') << '"'
				elsif value.match?(/^\s|\s$|[\n",]/)
					buffer << '"' << value.gsub('"', '""') << '"'
				else
					buffer << value
				end
			else # not escaping CSV injection
				if value.match?(/^\s|\s$|[\n",]/)
					buffer << '"' << value.gsub('"', '""') << '"'
				else
					buffer << value
				end
			end
		end
	end

	# Handle legacy `view_template` method
	def respond_to_missing(method_name, include_private)
		if method_name == :row_template && respond_to?(:view_template)
			true
		else
			super
		end
	end

	# Handle legacy `view_template` method
	def method_missing(method_name, ...)
		if method_name == :row_template && respond_to?(:view_template)
			warn "Deprecated: Use `row_template` instead."
			self.class.alias_method :row_template, :view_template
			view_template(...)
		else
			super
		end
	end

	private

	def ensure_escape_csv_injection_configured!
		if escape_csv_injection? == UNDEFINED
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
	end
end
