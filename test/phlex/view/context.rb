# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	let(:context_provider) do
		Class.new(Phlex::HTML) do
			def initialize(context)
				@context = context
			end

			def view_template
				prior_values = {}
				@context.each do |key, value|
					prior_values[key], context[key] = context[key], value
				end

				yield

				prior_values.each do |key, value|
					context[key] = value
				end
			end
		end
	end

	with "context" do
		view do
			def view_template
				div(class: [((context[:theme] == :dark) ? "dark" : "light")])
			end
		end

		let(:output) do
			context_provider.new(ctx).call do |component|
				component.__send__(:render, view)
			end
		end

		with "theme: dark" do
			let(:ctx) do
				{ theme: :dark }
			end

			it "renders with a dark class" do
				expect(output).to be == %(<div class="dark"></div>)
			end
		end

		with "theme: light" do
			let(:ctx) do
				{ theme: :light }
			end

			it "renders with a light class" do
				expect(output).to be == %(<div class="light"></div>)
			end
		end
	end
end
