# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	view do
		def view_template
			plain "Hi"
		end
	end

	with "#call" do
		it "renders the view" do
			expect(example.call).to be == "Hi"
		end
	end

	with "`render?` method returning false when the view context is true" do
		view do
			def view_template
				plain "Hi"
			end

			def render?
				!@_view_context
			end
		end
	end

	with "a view that yields an object" do
		view do
			def view_template
				yield(1, 2)
			end
		end

		let(:output) do
			example.call do |a, b|
				a + b
			end
		end

		it "yields the object correctly" do
			expect(output).to be == "3"
		end
	end

	with "a view that yields nothing" do
		view do
			def view_template
				yield
			end

			def some_method
				h1 { "Hi" }
			end
		end

		let(:output) do
			example.call(&:some_method)
		end

		it "yields the view itself" do
			expect(output).to be == "<h1>Hi</h1>"
		end
	end

	with "a view that is rendered twice" do
		view do
			def view_template
				plain "Hi"
			end
		end

		let(:output) do
			example.call
			example.call
		end

		it "raises an error" do
			expect { output }.to raise_exception(Phlex::DoubleRenderError)
		end
	end
end
