module Components
  class Title < Phlex::Component
    def template(&)
      h1(class: "text-2xl font-bold my-5", &)
    end
  end
end
