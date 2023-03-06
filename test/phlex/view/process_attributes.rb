# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	view do
		def template
			div(class: "foo")
		end

		def process_attributes(**attributes)
			attributes.transform_values { |v| "#{v}-bar" }
		end
	end

	it "works" do
		expect(output).to be == %(<div class="foo-bar"></div>)
	end
end
