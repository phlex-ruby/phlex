module Components
  class Heading < Phlex::Component
    def template(&)
      h2(class: "text-xl font-bold mt-10 mb-5", &)
    end
  end
end
