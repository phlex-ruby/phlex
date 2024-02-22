module Phlex
	class CSV::InjectionError < StandardError
		def initialize(suspcious_value, column_header)
			super(<<~MESSAGE)
				It appears that there is a value in this CSV that could be an attempt at CSV injection.

				#{
					if suspcious_value
						if column_header.nil?
							"The suspicious value is: #{suspcious_value}"
						else
							"The suspicious value is in the column '#{column_header}': #{suspcious_value}"
						end
					end
				}

				CSV injection is a security vulnerability where malicious spreadsheet formulae are used to execute code or exfiltrate data when a CSV is opened in a spreadsheet program such as Microsoft Excel or Google Sheets.

				For more information, see https://owasp.org/www-community/attacks/CSV_Injection

				If you determine that the data in this CSV is not malicious and you still need to render the CSV, there are two options:

				If you're sure this CSV will never be opened in a spreadsheet program, you can disable CSV injection escapes:

				  def escape_csv_injection? = false

				This is useful when using CSVs for byte-for-byte data exchange between secure systems.

				Alternatively, you can enable CSV injection escapes at the cost of data integrity:

				  def escape_csv_injection? = true

				Note: Enabling the CSV injection escapes will prefix any values that start with `=`, `+`, `-`, `@`, `\\t`, or `\\r` with a single quote `'` to prevent them from being interpreted as formulae by spreadsheet programs.

				You can also customize the injection escaping on a per-column or even per-value basis by defining `escape_csv_injection?` with an argument.

					def escape_csv_injection?(value) = value == SOME_KNOWN_SAFE_VALUE ? false : super

				  def escape_csv_injection?(_value, column) = column == "column_name" ? false : super

				Unfortunately, there is no one-size-fits-all solution to CSV injection. You need to decide based on your specific use case.
			MESSAGE
		end
	end
end
