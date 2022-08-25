module Components
  class Callout < Phlex::Component
    def template(&)
      DIV(class: "rounded bg-orange-50 text-sm p-5 border border-orange-100", &)
    end
  end
end
