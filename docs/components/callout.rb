# frozen_string_literal: true

module Components
  class Callout < Phlex::Component
    def template(&block)
      div(class: "rounded bg-orange-50 text-sm p-5 border border-orange-100", &block)
    end
  end
end
