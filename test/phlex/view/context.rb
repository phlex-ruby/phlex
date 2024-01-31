# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "context" do
		view do
			def view_template
				div(class: tokens(-> { context[:theme] == :dark } => { then: "dark", else: "light" }))
			end
		end

		with "theme: dark" do
			let(:context) do
				{ theme: :dark }
			end

			it "renders with a dark class" do
				expect(example.call(context:)).to be == %(<div class="dark"></div>)
			end
		end

		with "theme: light" do
			let(:context) do
				{ theme: :light }
			end

			it "renders with a light class" do
				expect(example.call(context:)).to be == %(<div class="light"></div>)
			end
		end
	end
end
