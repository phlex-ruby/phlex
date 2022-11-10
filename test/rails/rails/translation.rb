# frozen_string_literal: true

require "rails_helper"

describe Phlex::Translation do
	extend ViewHelper

	describe "#translate" do
		with "key starting with '.'" do
			view do
				include Phlex::Translation

				self.translation_path = "articles.card"

				def template
					text translate(".hello")
				end
			end

			it "returns translation using translation_path as scope" do
				expect(I18n).to receive(:translate).with("articles.card.hello").and_return("Olá")

				expect(output).to be == "Olá"
			end
		end

		with "key not starting with '.'" do
			view do
				include Phlex::Translation

				self.translation_path = "articles.card"

				def template
					text translate("hello")
				end
			end

			it "returns translation using key without translation_path as scope" do
				expect(I18n).to receive(:translate).with("hello").and_return("hola")

				expect(output).to be == "hola"
			end
		end
	end

	describe ".translation_path" do
		with "valid class name" do
			it "returns I18n scope using class anme" do
				expect(Views::Articles::Form.translation_path).to be == "views.articles.form"
			end
		end

		with "invalid class_name" do
			it "returns empty string" do
				view = Class.new(Phlex::HTML) do
					include Phlex::Translation
				end

				expect(view.translation_path).to be == ""
			end
		end

		it "memoizes result" do
			Views::Articles::Form.translation_path # memoize `translation_path` with original result: "articles.form"

			# Mock const_source_location. If memoization doesn't work, the `translation_path` should be "posts.form"
			mock(Views::Articles::Form) do |mock|
				mock.replace(:const_source_location) do
					["/my-app/app/views/posts/form.rb", 5]
				end
			end

			expect(Views::Articles::Form.translation_path).to be == "views.articles.form"
		end
	end
end
