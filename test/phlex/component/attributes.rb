# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  with "hash attributes" do
    component do
      def template
        div data: { name: { first: "Joel" } }
      end
    end

    it "flattens the attributes" do
      expect(output).to be == %(<div data-name-first="Joel"></div>)
    end
  end

  if RUBY_ENGINE == "ruby"
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
end
