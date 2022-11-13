# frozen_string_literal: true

module Phlex
	module Rails
		class Form < Phlex::HTML
			def initialize(model)
				@model = model
			end

			def self.input_field(method_name, type:)
				define_method method_name do |field, value: @model.attributes[field.to_s], **attributes|
					input(
						name: field_name(field),
						type: type,
						value: value,
						**attributes
					)
				end
			end

			def template(&block)
				form action: @url, method: @method do
					authenticity_token_field
					yield_content(&block)
				end
			end

			def authenticity_token_field
				input(
					name: "authenticity_token",
					type: "hidden",
					value: @_view_context.form_authenticity_token
				)
			end

			def submit(value)
				input(
					name: "commit",
					type: "submit",
					value: value
				)
			end

			def url
				@_view_context.url_for(@model)
			end

			def field_name(*field)
				@_view_context.field_name(ActiveModel::Naming.param_key(@model.class), *field)
			end

			input_field :url_field, type: "url"
			input_field :text_field, type: "text"
			input_field :date_field, type: "date"
			input_field :time_field, type: "time"
			input_field :week_field, type: "week"
			input_field :month_field, type: "month"
			input_field :email_field, type: "email"
			input_field :color_field, type: "color"
			input_field :hidden_field, type: "hidden"
			input_field :search_field, type: "search"
			input_field :password_field, type: "password"
			input_field :telephone_field, type: "tel"
			input_field :datetime_local_field, type: "datetime-local"
		end
	end
end
