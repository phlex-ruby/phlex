# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
	extend ViewHelper

	view do
		def template
			text "Hi"
		end
	end

	with "#call" do
		it "renders the component" do
			expect(example.call).to be == "Hi"
		end

		with "a spent component" do
			let(:example) { view.new.tap(&:call) }

			it "raises an ArgumentError" do
				expect { example.call }.to raise_exception RuntimeError,
					message: "The same component instance shouldn't be rendered twice"
			end
		end
	end
end
