# frozen_string_literal: true

module Phlex
  module Rails
    class Form < Phlex::Component
      def initialize(url:)
        super
      end

      def template
        form action: @url, method: "post" do
          input name: "authenticity_token", type: "hidden", value: @_view_context.form_authenticity_token
          yield self
        end
      end

      def submit(value: "Submit")
        input name: "commit", type: "submit", value: value
      end

      def text_area(name, id: name, value: _value_for(name), **attributes)
        textarea value, name: name, id: id, **attributes
      end

      def self.field(method_name, type:)
        define_method method_name do |name, id: name, value: _value_for(name), **attributes|
          input type: type, name: name, id: id, value: value, **attributes
        end
      end

      field :url_field, type: "url"
      field :text_field, type: "text"
      field :date_field, type: "date"
      field :time_field, type: "time"
      field :week_field, type: "week"
      field :month_field, type: "month"
      field :email_field, type: "email"
      field :color_field, type: "color"
      field :hidden_field, type: "hidden"
      field :search_field, type: "search"
      field :password_field, type: "password"
      field :telephone_field, type: "tel"
      field :datetime_local_field, type: "datetime-local"

      def select(name, id: name, value: nil, **attributes, &block)
        render Select.new(name, id: id, value: value, **attributes), &block
      end

      private

      def _value_for(key)
        return nil unless @model
        @model.attributes[key.to_s]
      end
    end
  end
end
