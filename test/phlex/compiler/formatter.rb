# frozen_string_literal: true

require "test_helper"

describe Phlex::Compiler::Formatter do
	let(:formatter) { Phlex::Compiler::Formatter.new("") }
	let(:output) { formatter.tap(&:flush).output }

	with "append block" do
		it "buffers an append string" do
			formatter.append do |f|
				f.text "a"
				f.text "b"
				f.text "c"
			end

			expect(output).to be == %(@_target << \"abc")
		end

		it "allows for breaks" do
			formatter.append do |f|
				f.text "a"
				f.text "b"
			end

			formatter.breakable(force: true)
			formatter.text "c"
			formatter.breakable(force: true)

			formatter.append do |f|
				f.text "d"
				f.text "e"
			end

			expect(output).to be == %(@_target << "ab"\nc\n@_target << "de")
		end
	end
end
