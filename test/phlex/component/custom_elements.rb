# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  with "custom elements" do
    component do
      register_element :trix_editor
      register_element :trix_toolbar

      def template
        div do
          trix_toolbar
          trix_editor "Hello"
        end
      end
    end

    it "produces the correct markup" do
      expect(output).to be ==
        "<div><trix-toolbar></trix-toolbar><trix-editor>Hello</trix-editor></div>"
    end
  end
end
