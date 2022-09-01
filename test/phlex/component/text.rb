# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  with "text" do
    component do
      def template
        text "Hi"
      end
    end

    it "produces the correct output" do
      expect(output).to be == "Hi"
    end
  end
end
