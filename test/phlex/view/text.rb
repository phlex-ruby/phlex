# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "deprecated text method" do
		view do
			def template
				text "Depreacted"
			end
		end

		it "renders content and prints deprecation warning" do
			expect(example).to receive(:warn).with("DEPRECATED: The `text` method has been deprecated in favour of `plain`. Please use `plain` instead. The `text` method will be removed in a future version of Phlex. Called from: test/phlex/view/text.rb:9:in `template'")
			expect(output).to be == "Depreacted"
		end
	end

	with "text" do
		view do
			def template
				plain "Hi"
			end
		end

		it "produces the correct output" do
			expect(output).to be == "Hi"
		end
	end

	with "int as text" do
		view do
			def template
				plain 1
			end
		end

		it "produces the correct output" do
			expect(output).to be == "1"
		end
	end

	with "float as text" do
		view do
			def template
				plain 2.0
			end
		end

		it "produces the correct output" do
			expect(output).to be == "2.0"
		end
	end

	with "an object that has no special format_object handling" do
		view do
			def template
				plain Object.new
			end
		end

		it "raises an ArgumentError" do
			expect { output }.to raise_exception(ArgumentError)
		end
	end
end
