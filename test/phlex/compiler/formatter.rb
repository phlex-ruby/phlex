# frozen_string_literal: true

require "test_helper"

describe Phlex::Compiler::Formatter do
	let(:formatter) { Phlex::Compiler::Formatter.new("") }
	let(:output) { formatter.tap(&:flush).output }

	with "append block" do
		it "buffers an append string" do
			formatter.append { _1.text "a" }
			formatter.append { _1.text "b" }
			formatter.append { _1.text "c" }

			expect(output).to be == %(@_target << \"abc")
		end

		it "allows for breaks" do
			formatter.append { _1.text "a" }

			formatter.breakable(force: true)
			formatter.text "b"
			formatter.breakable(force: true)

			formatter.append { _1.text "c" }

			expect(output).to be == %(@_target << "a"\nb\n@_target << "c")
		end
	end

	with "chain append" do
		it "chains the appends" do
			formatter.chain_append { _1.text "a" }
			formatter.chain_append { _1.text "b" }
			formatter.chain_append { _1.text "c" }

			expect(output).to be == %(@_target << a << b << c)
		end

		it "allows for breaks" do
			formatter.chain_append { _1.text "a" }

			formatter.breakable(force: true)
			formatter.text "b"
			formatter.breakable(force: true)

			formatter.chain_append { _1.text "c" }

			expect(output).to be == %(@_target << a\nb\n@_target << c)
		end
	end

	with "mixed appends" do
		it "works" do
			formatter.chain_append { _1.text "a" }
			formatter.chain_append { _1.text "b" }
			formatter.chain_append { _1.text "c" }

			formatter.append { _1.text "d" }
			formatter.append { _1.text "e" }
			formatter.append { _1.text "f" }

			formatter.chain_append { _1.text "g" }
			formatter.chain_append { _1.text "h" }
			formatter.chain_append { _1.text "i" }

			expect(output).to be == %(@_target << a << b << c << "def" << g << h << i)
		end
	end
end
