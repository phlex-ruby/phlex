# frozen_string_literal: true

require "test_helper"

ApplicationController = Class.new(ActionController::Base)

describe Phlex::Component do
  extend ComponentHelper

  with "#render_in" do
    component do
      def template(&block)
        article(&block)
      end
    end

    let :output do
      example.render_in ApplicationController.new.view_context do
        "<span>Hi</span>"
      end
    end

    it "renders the component with raw contents captured from the block" do
      expect(output).to be == %(<article><span>Hi</span></article>)
    end
  end
end
