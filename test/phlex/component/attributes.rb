# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  with "unique tag attributes" do
    component do
      def template
        div class: SecureRandom.hex
      end
    end

    let :report do
      component.new.call

      MemoryProfiler.report do
        2.times { component.new.call }
      end
    end

    it "doesn't leak memory" do
      expect(report.total_retained).to be == 0
    end
  end
end
